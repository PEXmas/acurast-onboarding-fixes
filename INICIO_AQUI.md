# Acurast Core: asistente opcional para Windows (MVP)

> **Experimental, no oficial.** No hay certificación de Acurast ni garantía de compatibilidad con nuevos dispositivos o nuevas versiones de Android.

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

Documentación adicional: [guía del fork](docs/GUIA_FORK.md) y [caso A52s](docs/CASO_A52S.md).