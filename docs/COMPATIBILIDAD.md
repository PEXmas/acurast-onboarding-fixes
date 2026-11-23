# Compatibilidad observada y lecciones de campo

**No es una lista oficial de equipos compatibles.** Es un registro de experiencias puntuales, dependientes de versión de Android, firmware, versión de Core y secuencia aplicada. Datos para lectura automática: [`compatibilidad/casos.json`](../compatibilidad/casos.json).

| Equipo | Android | Estado documentado | Procedencia |
| --- | --- | --- | --- |
| Xiaomi Redmi Note 12S (cámara dañada) | 14 | **Core 1.29.0**; Hub con conexión reciente/atestación observadas por usuario y Compute Status **Activo** después de **Instalar executor**. esta guía no evalúa producción | [Sesión guiada](CASO_REDMI_NOTE_12S.md) |
| Samsung Galaxy A52s 5G | 14 | Pantalla Core y Compute Status verde después de actualizar; **Online no verificado** | Sesión guiada anonimizada |
| Google Pixel 9 Pro Fold | 17 | Online **reportado** al actualizar Core 1.26.0 → 1.27.1 | README del proyecto original |
| Google Pixel 6 Pro | 14 | Online **reportado** tras una degradación de Android realizada aparte | README original |
| Samsung Galaxy A05 | 14 | Online **reportado** | README original |
| Samsung Galaxy A04 | 14 | Online **reportado** tras restauración stock; Knox seguía activado como alterado | README original |
| Xiaomi Redmi Note 13 | 13 | Online **reportado** tras resolver permisos USB y cuentas | README original |
| Samsung Galaxy S23 Ultra | 15 | Device Owner y lanzamiento registrados; **Online no confirmado** | README original |

El proyecto original describe casos concretos; este fork **no ha replicado** sus pruebas. Fuente: [README de bokiko/acurast-onboarding-fixes](https://github.com/bokiko/acurast-onboarding-fixes/blob/main/README.md).

## Redmi Note 12S: lecciones específicas para IA

En el [caso completo](CASO_REDMI_NOTE_12S.md), `adb install` falló con `INSTALL_FAILED_USER_RESTRICTED`, pero funcionó instalar **manualmente** una APK oficial ya verificada desde el Administrador de archivos de Xiaomi, después de su revisión de seguridad. Más tarde, Device Owner obtuvo un éxito explícito y Hub mostró conexión reciente y atestación; el aviso naranja `Executors not installed` se resolvió mediante la **opción local Ajustes → Instalar executor** en Acurast Processor. No se realizó actualización de toda la granja. Estos resultados describen únicamente enrolamiento y preparación inicial; no deben extrapolarse a otros firmware/modelos.

## A52s: incidentes y lo aprendido

| Situación | Observación | Lección / siguiente comprobación |
| --- | --- | --- |
| ADB no detectaba el móvil | Cambiar el cable permitió conectar | Comprobar primero cable y `adb devices`, sin modificar firmware |
| Error de permiso al enumerar usuario 10 | Existía el perfil de trabajo Acurast Lite | Examinar usuarios/perfiles y proteger datos antes de desenrolar Lite |
| `set-device-owner` arrojó `IllegalStateException` | `dpm list-owners` mostró propietario, pero sin éxito explícito | **Estado parcial; detener y diagnosticar.** No repetir el comando ni afirmar aprovisionamiento terminado |
| `CoreProvision check` pasó | Confirmó formato/interfaz de arranque, no autenticidad del QR | No interpretar `check` como emparejamiento |
| `Activity start accepted (0)` | Se abrió la interfaz Core en el teléfono | Verificar consentimiento, manager y Hub por separado |
| `Executors not installed` (naranja) | Después de actualizar Core, el estado se informó verde | Intentar actualización oficial cuando corresponda; no asumir causalidad ni funcionamiento Online |
| `adb.exe: no devices found` después de actualizar | Coincidió con modo dedicado | Puede ser restricción de Core **o** problema USB: no concluir que opciones de desarrollador están desactivadas sin comprobarlo |

Registro completo del caso: [`CASO_A52S.md`](CASO_A52S.md).

## Regla de interpretación para IA

- `hub_online_user_reported`: el dueño aportó capturas del teléfono y Hub con atestación y conexión reciente; **no** auditoría independiente ni confirmación de estabilidad posterior.
- `online_reported_upstream`: afirmación publicada por el proyecto original, no prueba independiente del fork.
- `core_ui_green_online_unverified`: se observaron interfaz y estado verde, sin Hub Online confirmado.
- `owner_and_launch_online_unverified`: no hay evidencia de conexión Online.
- Nuevas versiones o variantes del mismo modelo requieren nuevas pruebas. No prometer éxito a partir de un caso.
- Nunca usar un caso de degradación de Android, restauración de firmware, bloqueo de OEM o Knox como recomendación automática.
- Si la persona comparte capturas, eliminar/ocultar nombres, direcciones, direcciones de wallet, firmas, seriales, IMEI, códigos QR y enlaces de acceso.

## Cómo sumar otro equipo

Usar [la plantilla de reporte](../compatibilidad/PLANTILLA_CASO.md); actualizar el registro JSON solo con lo observado y su evidencia. El estado Online debe confirmarse explícitamente en Hub y consignarse como **reporte del usuario** o **verificación independiente**, no inferirse de la pantalla verde. Validar el JSON antes del PR con `python tools/validate_cases.py`.