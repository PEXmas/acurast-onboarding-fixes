# Plantilla: nueva observación de compatibilidad (sin datos personales)

> Este archivo es una plantilla, **no un resultado probado**. No adjuntar QR, archivos JSON de pairing, pantallas sin editar ni logs completos.

**Equipo (marca + modelo comercial):**  
**Android (versión principal):**  
**Core inicial / versión posterior (si está confirmado):**  
**Método observado (QR oficial / USB comunitario / actualización en Hub):**  
**Etapa alcanzada (instalación / Device Owner / pantalla Core / Compute Status / Hub Online):**  
**¿Online en Hub?** Sí, reportado / No / No comprobado  
**Estado de evidencia:** capturas editadas sin secretos / salida ADB depurada / observación verbal  
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
- No inferir éxito de procesador, ganancias ni compatibilidad universal de `Compute Status` verde.
- Publicar solo después de revisar con la persona que compartió los datos.

Luego añadir una entrada anonimizada a `casos.json` y ejecutar `python tools/validate_cases.py`.