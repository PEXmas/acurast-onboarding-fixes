# Caso experimental: Samsung Galaxy A52s (SM-A528B)

**Contexto:** noviembre de 2026; observación de una sesión guiada. No equivale a un enrolamiento certificado, repetible ni recomendado universalmente.

- Samsung A52s 5G, Android 14/API 34, firmware con bootloader bloqueado y arranque verificado green.
- Acurast Lite y su perfil de trabajo fueron retirados; quedó únicamente el usuario principal, sin cuentas visibles ni owners previos.
- Se verificó e instaló Acurast Core 1.27.1 (versionCode 136) con herramientas Android en Windows y Java 17.
- Se compiló `CoreProvision`; sus archivos se transfirieron con permisos restringidos y las pruebas `check` se ejecutaron sin lanzar Core.
- El comando `dpm set-device-owner` produjo `IllegalStateException` sobre el estado de aprovisionamiento, **aunque** el diagnóstico posterior registró a Acurast como Device Owner. Tratar esto como estado parcial, no como éxito.
- Después se ejecutó un único `CoreProvision launch` experimental; Android devolvió `Activity start accepted (0)`. El usuario observó la pantalla dedicada Core.
- El mensaje naranja `Executors not installed` desapareció después de actualizar desde la gestión de dispositivos. El usuario informó Compute Status verde y dejó de disponer de ADB.
- No se obtuvo una prueba independiente de disponibilidad Online, ingresos o ejecución de trabajos. No inferirla.

## Lecciones

Evitar repetir `set-device-owner` si devuelve una excepción. Separar preparación, registro, inicio de Core y verificación en Hub. La actualización oficial puede resolver problemas de ejecutores, pero eso no identifica una causa única ni demuestra que todo el proceso esté completado.

**Privacidad:** no almacenar direcciones, QR, payload, firmas, semillas o IDs completos en este documento.