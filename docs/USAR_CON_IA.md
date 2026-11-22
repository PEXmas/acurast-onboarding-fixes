# Cómo pedir recomendaciones a una IA usando el registro

Puedes darle a una IA con acceso a GitHub este repositorio:

**https://github.com/PEXmas/acurast-onboarding-fixes**

Pídele que lea `AGENTS.md`, `docs/COMPATIBILIDAD.md` y `compatibilidad/casos.json`. No todos los asistentes tienen acceso automático a GitHub: en ese caso, abre esos archivos y facilita solo el texto público, **nunca** el payload del QR.

## Mensaje de ejemplo para copiar

> Estoy probando Acurast Core en un teléfono [marca y modelo], Android [versión]. La app está en [versión conocida o desconocida] y muestra [error sin datos privados]. Antes de recomendar comandos, lee AGENTS.md, docs/COMPATIBILIDAD.md y compatibilidad/casos.json. ¿Hay casos comparables? Separa reportes comunitarios de pruebas verificadas y explícame un paso a la vez. No solicites QR, claves, semilla ni identificadores, y no ejecutes cambios irreversibles sin mi confirmación.

## Para contribuir

Después de probar un teléfono, explica a la IA **qué ocurrió realmente** y si Hub muestra Online. Puede proponer una entrada en el registro; revisa que no haya datos privados antes de crear un PR. No existe un sistema automático de seguimiento ni verificación continua en este fork.

**Nota:** el historial describe resultados anteriores, no garantiza que las mismas versiones, hardware o servidores de Acurast se comporten igual en el futuro.