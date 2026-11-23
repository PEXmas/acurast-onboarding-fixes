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

## Estado de las pruebas (noviembre de 2026)

- **GitHub Actions:** pruebas en Windows PowerShell 5.1 de sintaxis, casos JSON y consulta de releases oficiales completadas.
- **Windows real + Redmi Note 12S:** descarga y firma de APK estable Core 1.29.0 verificadas. El equipo bloqueó `adb install`, pero aceptó instalación manual desde Administrador de archivos después de comprobaciones de Seguridad Xiaomi.
- **Android 14 / Redmi Note 12S:** helper con hashes coincidentes pasó `check` sintético y real, Device Owner obtuvo `Success`, Hub mostró conexión reciente y atestación, y el estado naranja de ejecutores pasó a verde al usar `Ajustes → Instalar executor`. [Informe de campo](CASO_REDMI_NOTE_12S.md).
- **No verificado aún:** medición de trabajos, ACU, estabilidad prolongada, cleanup de los archivos privados si ADB desaparece, ni repetibilidad en otros modelos/firmware. El helper no autentica la firma de pairing del Hub.

La prueba es individual y guiada, no constituye una certificación ni autoriza automatizar Device Owner, borrar datos o actualizar una granja. No publicar información real de pairing en issues/PR.

## Compatibilidad e IA

La compatibilidad está documentada por **casos, evidencia y procedencia**, no como una lista garantizada. Antes de sugerir un procedimiento con otro celular, la IA debe leer [AGENTS.md](../AGENTS.md), [COMPATIBILIDAD.md](COMPATIBILIDAD.md), y [casos.json](../compatibilidad/casos.json). Para nuevas pruebas usa [la plantilla](../compatibilidad/PLANTILLA_CASO.md) y ejecuta `python tools/validate_cases.py`. Registrar solamente observaciones anonimizadas; un estado verde no equivale a confirmación Online en Hub.
