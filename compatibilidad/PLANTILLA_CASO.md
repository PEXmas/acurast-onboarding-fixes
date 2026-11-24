# Plantilla: nueva observación de compatibilidad (sin datos personales)

> Este archivo es una plantilla, **no un resultado probado**. No adjuntar QR, archivos JSON de pairing, pantallas sin editar ni logs completos.

**Equipo (marca + modelo comercial):**  
**Android (versión principal):**  
**Core inicial / versión posterior (si está confirmado):**  
**Método observado (QR oficial / USB comunitario / actualización en Hub):**  
**Etapa alcanzada (APK / Device Owner / lanzamiento / Manager / Hub / executor):**
**¿Manager configurado?** Sí / No / No comprobado
**¿Hub con última conexión o heartbeat reciente?** Sí, reportado / No / No comprobado
**¿Executor instalado y Compute Status verde?** Sí, reportado / No / No comprobado
**¿Se completó el enrolamiento en Hub?** Sí, reportado / No / Pendiente  
**¿Online en Hub?** Sí, reportado / No / No comprobado  
**Estado de evidencia:** Hub Phones del dispositivo correcto / captura local Core / dashboard propio / salida ADB depurada / relato verbal (no son equivalentes)  
**Origen de la evidencia:** observación guiada / reporte de la comunidad / documentación del proveedor  
**Fecha general (mes/año, opcional):**  
**Advertencias y límites:**

## Incidentes y resolución

| Síntoma exacto (sin datos privados) | Paso observado | Resultado comprobado |
| --- | --- | --- |
| [mensaje] | [acción] | [resultado] |

## Control de privacidad obligatorio

- No incluir datos del usuario, identificadores del equipo, serial, IMEI, número telefónico, email, IP ni localización.
- No incluir wallet, frases semilla, claves, QR, JSON de emparejamiento, firmas o marcas temporales del QR.
- Si hubo error de `dpm set-device-owner`, registrarlo como **estado parcial** aunque aparezca Device Owner.
- Esta plantilla documenta exclusivamente el enrolamiento; no registrar ACU, ingresos ni rendimiento. Distinguir Device Owner, Manager, conexión en Hub y executor inicial; un indicador verde no garantiza compatibilidad universal.
- Registrar por separado instalación ADB y manual; un error de ADB no demuestra firma APK inválida.
- Si se manejó `payload.json` en USB, documentar si pudo borrarse la copia temporal sin revelar QR, hashes, firmas o timestamps exactos.
- No atribuir una captura de **otro procesador** o un dashboard local al dispositivo observado en **Acurast Hub Phones**.
- Si hay toques fantasma, registrar que scrcpy puede desconectarse y si el mouse OTG se **probó realmente**, no solo se propuso.
- Publicar solo después de revisar con la persona que compartió los datos.

Luego añadir una entrada anonimizada a `casos.json` y ejecutar `python tools/validate_cases.py`.