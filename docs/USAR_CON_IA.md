# Cómo pedir recomendaciones a una IA usando el registro

Este registro sirve exclusivamente para **enrolamiento alternativo por USB sin escanear QR**, principalmente en equipos dedicados después de un restablecimiento. Los datos **Copy QR Data** vigentes del Hub siguen siendo imprescindibles, pero deben mantenerse privados. No pedir ni elaborar análisis de producción, ACU, recompensas, epochs o ingresos dentro del repositorio. Leer primero el [alcance del fork](ALCANCE.md).

Puedes darle a una IA con acceso a GitHub este repositorio:

**https://github.com/PEXmas/acurast-onboarding-fixes**

Pídele que lea `AGENTS.md`, `docs/COMPATIBILIDAD.md` y `compatibilidad/casos.json`. Para Xiaomi, Android 14, cámara dañada o `Executors not installed`, debe consultar también [`docs/CASO_REDMI_NOTE_12S.md`](CASO_REDMI_NOTE_12S.md). No confundir sus resultados con los del [A52s](CASO_A52S.md). No todos los asistentes tienen acceso automático a GitHub: en ese caso, abre esos archivos y facilita solo el texto público, **nunca** el payload del QR.

## Mensaje de ejemplo para copiar

> Estoy probando Acurast Core en [modelo], Android [versión], firmware [si lo sé]. La app es [versión] y aparece [mensaje sin datos privados]. Lee AGENTS.md, docs/COMPATIBILIDAD.md, compatibilidad/casos.json y el caso detallado comparable, especialmente docs/CASO_REDMI_NOTE_12S.md si es Xiaomi. Separa APK, Device Owner, launch, Manager, atestación, conexión reciente de Hub y disponibilidad inicial de executor. El fin es enrolar el equipo, no evaluar ganancias ni producción. Indica qué fue observado directamente, reportado por usuario o leído en upstream. Recomienda un paso seguro a la vez. No pidas QR, payload, wallet, semilla, seriales ni capturas sin ocultar. No propongas acciones irreversibles sin mi autorización específica.

## Para contribuir

Después de probar un teléfono, explica a la IA **qué ocurrió realmente** y si Hub muestra Online. Puede proponer una entrada en el registro; revisa que no haya datos privados antes de crear un PR. No existe un sistema automático de seguimiento ni verificación continua en este fork.

**Nota:** el historial describe resultados anteriores, no garantiza que las mismas versiones, hardware o servidores de Acurast se comporten igual en el futuro.