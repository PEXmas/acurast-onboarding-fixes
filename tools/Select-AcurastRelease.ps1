# Verifica releases oficiales y, opcionalmente, descarga una APK sin instalarla.
# No ejecuta adb install, Device Owner ni CoreProvision.
[CmdletBinding()]
param(
  [ValidateSet('LatestStable','PreviousStable')][string]$Channel='PreviousStable',
  [switch]$Download,
  [string]$OutputFolder="$env:USERPROFILE\acurast-core\verified-releases",
  [string]$SdkRoot="$env:LOCALAPPDATA\Android\Sdk"
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
$api='https://api.github.com/repos/Acurast/acurast-processor-update/releases?per_page=100'
$headers=@{Accept='application/vnd.github+json';'User-Agent'='Acurast-Windows-MVP';'X-GitHub-Api-Version'='2022-11-28'}
$trustedSigner='ec70c2a4e072a0f586552a68357b23697c9d45f1e1257a8c4d29a25ac4982433'
$expectedPackage='com.acurast.attested.executor.canary'
$releases=Invoke-RestMethod -Method Get -Uri $api -Headers $headers -TimeoutSec 40
# Invoke-RestMethod returns a JSON array as a single array object in Windows PowerShell 5.1.
# Pipe the array directly so Where-Object enumerates the individual release objects.
$stable=@($releases | Where-Object {
  (-not $_.draft) -and (-not $_.prerelease) -and ([string]$_.tag_name -match '^processor-[0-9]+\.[0-9]+\.[0-9]+$')
} | Sort-Object -Property @{Expression={[version]([regex]::Match([string]$_.tag_name,'[0-9]+\.[0-9]+\.[0-9]+').Value)}} -Descending)
if ($stable.Count -lt 2) { throw 'No se confirmaron dos versiones estables; no continuar.' }
$idx=if($Channel -eq 'LatestStable'){0}else{1}
$rel=$stable[$idx]
$version=([regex]::Match([string]$rel.tag_name,'[0-9]+\.[0-9]+\.[0-9]+')).Value
$name="processor-$version.apk"
$assets=@($rel.assets | Where-Object {$_.name -ceq $name})
if($assets.Count -ne 1){throw "APK no encontrada para $version"}
$asset=$assets[0]
$url="https://github.com/Acurast/acurast-processor-update/releases/download/$($rel.tag_name)/$name"
if ([string]$asset.browser_download_url -cne $url) {throw 'Origen de descarga inesperado.'}
Write-Output ("Ultima estable: {0}" -f $stable[0].tag_name)
Write-Output ("Estable anterior: {0}" -f $stable[1].tag_name)
Write-Output ("Seleccionada: {0}" -f $rel.tag_name)
Write-Output ("Publicacion oficial: {0}" -f $rel.html_url)
if(-not $Download){Write-Output 'Solo consulta: sin descarga ni instalacion.';return}
$hm=[regex]::Match([string]$asset.digest,'^sha256:([a-fA-F0-9]{64})$')
if(-not $hm.Success){throw 'Sin digest SHA-256 publicado por GitHub; detener.'}
$expectedHash=$hm.Groups[1].Value.ToLowerInvariant()
$signer=Join-Path $SdkRoot 'build-tools\35.0.0\apksigner.bat'
$aapt=Join-Path $SdkRoot 'build-tools\35.0.0\aapt.exe'
if(-not (Test-Path $signer -PathType Leaf) -or -not (Test-Path $aapt -PathType Leaf)){throw 'Se necesitan Android Build Tools 35.'}
New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
$apk=Join-Path $OutputFolder $name
if(Test-Path $apk){throw 'Archivo ya existe; no se sobreescribe.'}
try {
  Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $apk -TimeoutSec 240
  $hash=(Get-FileHash -LiteralPath $apk -Algorithm SHA256).Hash.ToLowerInvariant()
  if($hash -ne $expectedHash){throw 'Hash SHA-256 distinto.'}
  $sig=@(& $signer verify --verbose --print-certs $apk 2>&1)
  if($LASTEXITCODE -ne 0){throw 'Firma APK invalida.'}
  $text=$sig -join [Environment]::NewLine
  $match=[regex]::Match($text,'(?im)^Signer #1 certificate SHA-256 digest:\s*([a-f0-9]{64})\s*$')
  if(-not $match.Success -or $match.Groups[1].Value.ToLowerInvariant() -ne $trustedSigner){throw 'Certificado distinto; requiere revision humana.'}
  if($text -notmatch '(?im)^Number of signers:\s*1\s*$'){throw 'Cantidad de firmantes inesperada.'}
  $meta=@(& $aapt dump badging $apk 2>&1)
  if($LASTEXITCODE -ne 0){throw 'No se pudo leer el manifest.'}
  $line=@($meta | Where-Object {$_ -match '^package:'} | Select-Object -First 1)
  if($line.Count -ne 1){throw 'Manifest sin package.'}
  $pkg=[regex]::Match([string]$line[0],"name='([^']+)'\s+versionCode='(\d+)'\s+versionName='([^']+)'")
  if(-not $pkg.Success -or $pkg.Groups[1].Value -ne $expectedPackage -or $pkg.Groups[3].Value -ne $version){throw 'Paquete o version inesperada.'}
  Write-Host "APK VERIFICADA: $apk"
  Write-Host 'NO se instalo ni modifico el telefono.'
} catch {
  if(Test-Path $apk){Remove-Item $apk -Force}
  throw
}
