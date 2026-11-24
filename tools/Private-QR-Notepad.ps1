# QR solo local, FUERA del repositorio Git. No lee portapapeles ni envia datos.
[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$dir = Join-Path $env:LOCALAPPDATA 'AcurastPairing'
$file = Join-Path $dir 'payload.json'
if (-not (Test-Path -LiteralPath $dir)) {
  New-Item -ItemType Directory -Path $dir | Out-Null
  $sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
  & icacls.exe $dir /inheritance:r /grant:r ('*' + $sid + ':(OI)(CI)F') | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'No se pudieron proteger los permisos de la carpeta.' }
} else {
  Write-Host 'Carpeta existente: revisa manualmente sus permisos antes de utilizarla.'
}
Write-Host 'Abriendo Bloc de notas local; NO pegues el QR en ChatGPT/GitHub.'
Start-Process -FilePath notepad.exe -ArgumentList ('"{0}"' -f $file) -Wait
if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
  Write-Host 'No se guardo payload.json. Sin cambios.'
  return
}
$bytes = (Get-Item -LiteralPath $file).Length
if ($bytes -lt 32 -or $bytes -gt 65536) { throw 'Tamaño inesperado del JSON.' }
try { $null = Get-Content -LiteralPath $file -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop }
catch { throw 'El archivo no es JSON valido. No se muestra contenido.' }
Write-Host 'Sintaxis JSON correcta. NO se ha verificado la firma del Hub ni la vigencia.'
