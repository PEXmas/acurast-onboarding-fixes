# Caso probado: Redmi Note 12S sin cámara — Core 1.29.0

> English companion: [Redmi Note 12S field report](CASE_REDMI_NOTE_12S.md) · [AI decision playbook](FIELD_PLAYBOOK.md).

> Observación guiada en noviembre de 2026. No es documentación oficial de Acurast, ni una garantía para otros dispositivos. Se conserva solo un resumen técnico **anonimizado**; los QR, direcciones, seriales, correos, fotos sin anonimizar y archivos privados no forman parte del repositorio.

## Dispositivo y resultado

- **Modelo:** Xiaomi Redmi Note 12S (`2303ERA42L`), cámara no funcional.
- **Sistema:** Android 14 / API 34; HyperOS `V816.0.12.0.UHZMIXM`; bootloader bloqueado (`ro.boot.flash.locked=1`), verified boot `green`.
- **PC:** Windows, PowerShell, ADB, Android SDK Build Tools 35.0.0.
- **Core:** `com.acurast.attested.executor.canary`, versión **1.29.0**, código **144**. APK oficial comprobada por SHA-256 publicado, firma del APK y paquete esperado.
- **Emparejamiento:** `dpm set-device-owner` devolvió **Success** y `dpm list-owners` confirmó `DeviceOwner,Affiliated` en usuario 0; el helper devolvió `Activity start accepted (0)`.
- **Evidencia posterior:** captura facilitada por el propietario de **Hub Phones** con Core 1.29.0, atestación y **última conexión reciente**; pantalla Core con **Manager asignado**, heartbeat reciente, atestación y Compute Status verde **Activo** tras seleccionar **Ajustes → Instalar executor**.
- **Clasificación:** `hub_online_user_reported` (`online_verified=false`): conexión reciente/atestación y estado activo **observados en capturas del usuario**, no auditoría independiente. Esta observación documenta el **enrolamiento y su comprobación inicial**, no la producción del equipo.

## Secuencia y puntos que cambiaron el resultado

| Fase | Lo que realmente ocurrió | Lección para futuras asistencias IA |
| --- | --- | --- |
| Inspección | `adb devices` conectó; Android 14, usuario 0, sin usuarios adicionales; `dpm list-owners` inicialmente falló con `Calling identity is not authorized` | Ese error significa **consulta no autorizada**, no prueba de que exista o no exista un Device Owner |
| Aplicaciones | Al principio no había Lite ni Core instalados en el Redmi consultado | No atribuirle registros históricos de otro teléfono por coincidir el nombre de modelo |
| Instalación APK | `adb install` falló repetidamente con `INSTALL_FAILED_USER_RESTRICTED`, incluso tras activar **Instalar vía USB** y **Depuración USB (ajustes de seguridad)** | Separar bloqueo de ADB de integridad de APK. No repetir sin nueva evidencia |
| Restricción Xiaomi | Para habilitar opciones USB, HyperOS solicitó iniciar sesión Xiaomi y colocar SIM; Seguridad notificó bloqueo de instalación por USB | Los requisitos se observaron en **este equipo**, no se generalizan a Xiaomi |
| Instalación manual | El propietario copió la APK oficial verificada a Descargas, la abrió con **Administrador de archivos**, autorizó temporalmente esa fuente y pasó la revisión del instalador Xiaomi; ADB confirmó Core 1.29.0/144 | La alternativa manual funcionó **sin desactivar Play Protect**; no recomendar omitir verificaciones ni forzar instalación ante alerta explícita de malware |
| Preparación | El dueño retiró Google y Xiaomi de Cuentas y sincronización, tras confirmar el uso dedicado; luego `dpm list-owners` mostró `no owners`, solo usuario 0, y Core no estaba ejecutándose | Cuentas y permisos son puertas independientes. Proteger datos antes de retirar cuentas; no atribuir la mejora a un único ajuste |
| Herramienta USB | Los SHA-256 de `CoreProvision.java`, `check-payload.py` y `helper.zip` coincidieron con referencias del repo; `check` pasó primero con JSON ficticio | Comprobar exactamente la revisión; no confundir un archivo preexistente con la revisión esperada |
| Datos de Hub | El dueño creó `payload.json` local privado fuera de Git, validó esquema y ventana temporal, lo transfirió a carpeta protegida de Android (`700` / helper `444` / payload `600`); coincidencia local de SHA-256; `CoreProvision ... check` pasó | La comprobación de cinco campos/PersistableBundle **no autentica firma del Hub**. No divulgar QR, JSON, hashes, firmas o wallet |
| Device Owner | Con autorización explícita, preflight y QR declarado vigente, Android respondió `Success`; lectura posterior confirmó un Device Owner Acurast | **No ejecutar automáticamente**. Si ocurre error, parar; no repetir `set-device-owner` a ciegas |
| Inicio | Un solo `CoreProvision ... launch` devolvió `Activity start accepted (0)` | El inicio aceptado **no es prueba suficiente** de pairing ni de estar Online |
| Hub y estado inicial | Hub mostró procesador atestado con conexión reciente; Core mostró `Executors not installed` naranja | Un procesador puede estar vinculado/conectado y aun carecer de ejecutores instalados |
| Corrección final | Desde la **rueda de ajustes de Acurast Processor en el teléfono**, se pulsó **Instalar executor**; Compute Status pasó a **verde/Activo**, conservando manager, heartbeat y atestación | Si esa opción existe y Hub/Manager ya son visibles, comprobar el instalador local antes de reinstalar Core, repetir enrolamiento o actualizar toda la granja |

## Guía de interpretación para IA

1. **Separar las puertas del enrolamiento:** (a) APK verificada/instalada, (b) Device Owner confirmado, (c) launch aceptado, (d) Manager y conexión/atestación en Hub, (e) executor listo si aplica. No interpretar una etapa como confirmación automática de la siguiente.
2. **Distinguir el caso Redmi del A52s:** en el A52s el verde ocurrió después de una actualización; **en este Redmi ocurrió al usar la acción local `Instalar executor`**, sin actualización de APK observada.
3. **No saltar al paso irreversible:** revisar usuario/perfiles, cuentas, firma/paquete de APK, QR vigente, `check` y consentimiento específico. Device Owner puede requerir restablecimiento para recuperar el teléfono. No flashear, desbloquear bootloader, eliminar datos ni manipular un owner ajeno.
4. **Asistir un paso a la vez:** en errores de instalación USB, revisar el mensaje del sistema antes de repetir. Una instalación manual solo es apropiada con origen y firma verificados y sin alertas de seguridad graves.
5. **QR protegido:** guardar `Copy QR Data` solo en un archivo local restringido; verificar tiempo local y vencimiento real de Hub. Nunca poner el contenido en mensajes, Git, logs o capturas. El helper no verifica la firma criptográfica de pairing.
6. **Cierre del objetivo:** Manager asociado, conexión reciente y atestación en Hub respaldan el enrolamiento; el estado de executor es una comprobación inicial adicional. No ampliar este caso hacia métricas de producción.

## Pendientes y límites

- No se auditó de manera independiente Hub; el registro describe la vinculación y estado inicial observados por el propietario, no un seguimiento operativo prolongado.
- No se han probado Core 1.30 RC, otras versiones de HyperOS, Xiaomi sin SIM o con una cuenta Xiaomi permanentemente conectada.
- La eliminación posterior de las copias privadas de `payload.json` en el teléfono **no está confirmada** tras entrar en modo dedicado. Si ADB no está disponible, registrar ese límite en lugar de intentar cambios peligrosos.
- La cámara dañada no impidió este flujo USB, pero su éxito no garantiza compatibilidad con otros equipos.

## Rutas relacionadas

- [Compatibilidad y niveles de evidencia](COMPATIBILIDAD.md) · [Registro legible por IA](../compatibilidad/casos.json)
- [Guía Xiaomi](xiaomi.md) · [Síntomas y soluciones](troubleshooting.md) · [Puntos de parada](checklist.md)
- [Comparación: caso Samsung A52s](CASO_A52S.md) · [Cómo usar esta información con IA](USAR_CON_IA.md)
