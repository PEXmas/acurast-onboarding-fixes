# Guía de la extensión Windows

Esta extensión mantiene intactos `tools/CoreProvision.java`, `tools/check-payload.py` y el procedimiento USB original.

## Principios

1. Inspección de versiones separada de enrolamiento.
2. Solo versiones publicadas como estables en el repositorio oficial de Acurast; nunca RC o borradores.
3. No confiar únicamente en la fecha o el nombre de APK: verificar digest, firma Android y nombre de paquete.
4. `payload.json` fuera del repositorio y nunca en la consola, logs ni sistemas de IA.
5. Mantener **Gate A** manual para Device Owner; no automatizar el registro, apertura de Core ni restablecimiento de fábrica.
6. Ante error o estado parcial, detenerse y diagnosticar antes de continuar.
7. Documentar resultados sin secretos ni identificadores de dispositivos.

## Archivo privado de QR

El script `tools/Private-QR-Notepad.ps1` crea, si hace falta, un directorio local para un archivo JSON y abre Bloc de notas. No lee la wallet y no envía datos. Una validación JSON básica no equivale a verificar la firma del Hub. Debe emplearse el validador original con las cautelas correspondientes.

## Versiones

`tools/Select-AcurastRelease.ps1` ofrece `LatestStable` y `PreviousStable`. Puede consultar solo metadatos o descargar la APK para verificación **sin instalarla**. El certificado permitido se basa en la APK 1.27.1 verificada en el caso de prueba; un cambio legítimo de firmante requiere una nueva revisión manual.

## Pruebas pendientes

Se necesita un ciclo de pruebas en Windows PowerShell 5.1, consultas a GitHub, validación de APK y pruebas con dispositivos dedicados antes de recomendar el procedimiento como estable. No publicar detalles de emparejamiento reales en issues o PR.