# Menu de diagnostico y descargas; nunca modifica el telefono.
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host 'ACURAST CORE - WINDOWS MVP'
Write-Host '1) Consultar estable anterior'
Write-Host '2) Consultar ultima estable'
Write-Host '3) Descargar y verificar estable anterior (sin instalar)'
Write-Host '4) Preparar QR privado en Bloc de notas'
Write-Host '5) Diagnosticar Android por ADB (solo lectura)'
Write-Host '0) Salir'
$choice = Read-Host 'Elige una opcion'
switch ($choice) {
  '1' { & (Join-Path $root 'tools\Select-AcurastRelease.ps1') -Channel PreviousStable }
  '2' { & (Join-Path $root 'tools\Select-AcurastRelease.ps1') -Channel LatestStable }
  '3' { & (Join-Path $root 'tools\Select-AcurastRelease.ps1') -Channel PreviousStable -Download }
  '4' { & (Join-Path $root 'tools\Private-QR-Notepad.ps1') }
  '5' { & (Join-Path $root 'tools\Read-Device-Status.ps1') }
  '0' { Write-Host 'Sin cambios.' }
  default { Write-Host 'Opcion no reconocida; sin cambios.' }
}