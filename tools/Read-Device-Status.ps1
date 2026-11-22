# SOLO LECTURA: no instala, no cambia Device Owner, no muestra QR ni wallet.
[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$adb = (Get-Command adb -ErrorAction Stop).Source
Write-Host 'DISPOSITIVOS ADB:'
& $adb devices
Write-Host 'ANDROID:'
& $adb -d shell getprop ro.build.version.release
Write-Host 'BOOTLOADER (informativo):'
& $adb -d shell getprop ro.boot.flash.locked
Write-Host 'USUARIO ACTUAL:'
& $adb -d shell am get-current-user
Write-Host 'PERFILES:'
& $adb -d shell pm list users
Write-Host 'DEVICE OWNER:'
& $adb -d shell dpm list-owners
Write-Host 'VERSION CORE (si esta instalada):'
& $adb -d shell dumpsys package com.acurast.attested.executor.canary | Select-String 'versionCode=|versionName=' | Select-Object -First 4
Write-Host 'Fin del diagnostico. Esta salida NO demuestra elegibilidad para enrolamiento.'
