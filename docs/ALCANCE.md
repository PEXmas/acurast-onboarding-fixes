# Alcance del fork: enrolamiento alternativo al escaneo del QR

**Objetivo único:** guiar, con asistencia de IA, la **configuración/enrolamiento de Acurast Core mediante USB y ADB**, como alternativa a **escanear** el código QR con la cámara. Es especialmente útil al preparar un dispositivo dedicado **después de un restablecimiento de fábrica**, cuando el flujo habitual de escaneo de QR no funciona, por ejemplo por cámara averiada o fallos de aprovisionamiento.

## Qué sí hace este proyecto

- Ayuda a diagnosticar la preparación de Android tras el restablecimiento, el estado de cuentas, usuarios/perfiles, posibles administradores, permisos USB y versiones de Core.
- Documenta la descarga y verificación de la **APK oficial** y métodos de instalación observados, sin desactivar controles de seguridad.
- Explica cómo obtener **Copy QR Data** desde el **Hub del propietario** y guardarlo únicamente en un archivo local protegido: el QR/datos de vinculación **siguen siendo necesarios**. Se evita el *escaneo con cámara*, no la autorización ni la firma de Hub.
- Guía comprobaciones con el helper USB comunitario, autoriza operaciones privilegiadas **una por una** y verifica por separado el registro Device Owner, el lanzamiento, el Manager, la atestación y la **conexión reciente en Hub**.
- Registra casos concretos y errores de enrolamiento para que una IA explique el siguiente paso con evidencia, sin dar por compatibles todos los dispositivos.
- Considera la instalación de executor y el estado verde **solo como cierre operativo del enrolamiento**, no como análisis de rendimiento.

## Qué queda fuera

- **No** estima, registra, compara ni predice producción de ACU, ingresos, rentabilidad, rendimiento por epoch ni resultados de cómputo.
- **No** administra la granja, monitoriza recompensas o automatiza operaciones continuas tras el enrolamiento.
- **No** sustituye el proceso de firma/autorización del Hub, ni vuelve opcional el payload privado.
- **No** restablece teléfonos, elimina cuentas, modifica firmware, registra Device Owner, lanza pairing ni vincula una wallet **automáticamente**.
- **No** ofrece bypass de seguridad, root, bootloader desbloqueado ni promesas de compatibilidad general.

## Cuándo corresponde usarlo

1. El propietario está preparando **un teléfono propio y dedicado**, en particular después de un reset, o investigando una preparación fallida.
2. El diagnóstico confirma que el equipo realmente está libre de administradores/perfiles incompatibles y que cuenta con las condiciones de Acurast; **un reset no garantiza esto por sí solo**.
3. El titular acepta el riesgo de perder el uso normal del teléfono, protege sus datos y autoriza individualmente cada cambio irreversible.
4. El Hub genera un emparejamiento nuevo y vigente; nunca se reutilizan QR caducados ni se manipula su firma/timestamp.
5. La prueba final confirma Manager asociado y conexión reciente/atestación en Hub. Si el sistema muestra `Executors not installed`, puede comprobarse la opción oficial local `Instalar executor` cuando exista.

## Reglas para asistentes de IA

Leer primero [AGENTS.md](../AGENTS.md), [registro de compatibilidad](COMPATIBILIDAD.md), [checklist](checklist.md) y el [caso comparable](CASO_REDMI_NOTE_12S.md). Diferenciar **APKs instaladas, Device Owner, launch, vinculación y Hub**. No pedir a nadie que comparta QR, payload, cuentas, claves, seriales o capturas sin anonimizar. Un helper `check` no autentica firma del Hub, y `Activity start accepted (0)` no acredita emparejamiento. Detenerse tras errores de privilegios; no repetir comandos automáticamente.

**Carácter del proyecto:** extensión comunitaria no oficial, con pruebas por modelo/versión. La guía es para uso manual y asistencia de IA; no un instalador garantizado de un clic.
