# Acurast Core: asistente opcional para Windows (MVP)

> **Experimental, no oficial.** Este proyecto se centra exclusivamente en **enrolar Core por USB sin escanear el QR con cámara**, especialmente al preparar un equipo dedicado después de restablecerlo. **Sí se necesitan datos vigentes de Copy QR Data obtenidos desde Hub.** No mide producción, ACU, ingresos ni rendimiento. [Alcance detallado](docs/ALCANCE.md). No hay certificación de Acurast ni garantía de compatibilidad con nuevos dispositivos o nuevas versiones de Android.

Este fork conserva el procedimiento comunitario original y añade herramientas **no destructivas** para Windows PowerShell 5.1. No se ejecutan `adb install`, `dpm set-device-owner`, `CoreProvision launch`, `factory reset` ni acciones sobre la wallet automáticamente.

## Uso básico

Abre PowerShell en la raíz del repositorio y ejecuta:

```powershell
& .\INICIAR.ps1
```

Elige consulta de **última estable** o **estable anterior**; la selección no implica que esa versión sea compatible con el asistente de enrolamiento. El módulo de descarga opcional exige Android SDK Build Tools 35 y detiene el proceso si no puede confirmar hash, firma y paquete.

Para preparar el QR en un archivo local fuera del repositorio:

```powershell
& .\tools\Private-QR-Notepad.ps1
```

El archivo se almacena en `%LOCALAPPDATA%\AcurastPairing\payload.json`. La comprobación de sintaxis **no** valida la firma criptográfica del Hub ni el estado de vinculación. Nunca subas el QR, una firma, claves o semilla a GitHub o al chat.

Para diagnóstico de solo lectura (ADB):

```powershell
& .\tools\Read-Device-Status.ps1
```

## Límites y precauciones

- Revisa la [guía USB original](docs/usb-onboarding.md) y sus puntos de parada antes de cualquier cambio en Device Owner.
- Una excepción de `set-device-owner` es un **fallo**, incluso si `dpm list-owners` registra un owner. No repitas el comando a ciegas.
- El resultado `CoreProvision check` no confirma la autenticidad de la firma del QR ni el enrolamiento.
- La pantalla Core o Compute Status verde por sí sola no garantiza estado **Online** en Hub.
- Actualizar desde la aplicación o el Hub es preferible a repetir el enrolamiento de un procesador en funcionamiento.
- No uses la versión estable anterior sin comprobar su compatibilidad con el procedimiento vigente.
- Los scripts aún requieren pruebas integrales en Windows y con dispositivos de prueba.

Documentación adicional: [guía del fork](docs/GUIA_FORK.md), [playbook de IA (inglés)](docs/FIELD_PLAYBOOK.md), [caso Redmi Note 12S](docs/CASO_REDMI_NOTE_12S.md), [caso Samsung A04 Knox 1](docs/CASE_SAMSUNG_A04_SM_A045M.md) y [caso A52s](docs/CASO_A52S.md). El Redmi documenta una sesión exitosa de vinculación en Hub y activación local de ejecutores; **el menú Windows no automatiza enrolamiento**, y el propósito del fork termina al verificar el enrolamiento, el vínculo en Hub y, si procede, los ejecutores.

## ¿Qué teléfonos han sido probados?

Consulta [el registro de compatibilidad](docs/COMPATIBILIDAD.md) y su [archivo para IA](compatibilidad/casos.json). Compara siempre modelo **y** versión de Android; hay reportes comunitarios y resultados propios con distintos niveles de evidencia. Para una IA, lee primero [AGENTS.md](AGENTS.md) y [este mensaje listo para copiar](docs/USAR_CON_IA.md). Para añadir otro equipo, utiliza [la plantilla anónima](compatibilidad/PLANTILLA_CASO.md). La lista no certifica compatibilidad.
