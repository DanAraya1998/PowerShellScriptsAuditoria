# Scripts de Auditoría en PowerShell para Windows

Este repositorio contiene una colección de scripts en PowerShell desarrollados para realizar una auditoría básica de seguridad en equipos Windows.  
Los scripts permiten revisar configuraciones clave del sistema, identificar posibles debilidades y generar evidencia técnica para análisis o presentación de resultados.

## Objetivo

Evaluar controles básicos de seguridad en Windows, incluyendo actualizaciones, cifrado, usuarios locales, políticas de contraseña, antivirus, firewall, red, tareas programadas, logs y recursos compartidos SMB.

## Scripts incluidos

| Script | Criterio auditado | Descripción |
|---|---|---|
| `01_Actualizaciones.ps1` | Actualizaciones pendientes | Revisa si existen actualizaciones de software pendientes en Windows Update. |
| `02_BitLocker.ps1` | Cifrado de disco | Consulta el estado de BitLocker, porcentaje de cifrado y estado de protección. |
| `03_Usuarios.ps1` | Usuarios y administradores locales | Lista usuarios locales y miembros del grupo de administradores. |
| `04_Contrasennas.ps1` | Políticas de contraseñas | Revisa longitud mínima, complejidad, historial, bloqueo de cuentas y usuarios sin contraseña requerida. |
| `05_Defender.ps1` | Microsoft Defender | Consulta el estado del antivirus, protección en tiempo real, firmas, exclusiones y configuraciones relevantes. |
| `06_FirewallYRed.ps1` | Firewall y perfil de red | Revisa perfiles del firewall, perfil de red activo y reglas entrantes permitidas. |
| `07_PuertosConexionesDNS.ps1` | Puertos, conexiones y DNS | Lista puertos TCP en escucha, conexiones activas y entradas de caché DNS. |
| `08_InicioAutoYTareasProgramadas.ps1` | Inicio automático y tareas programadas | Muestra programas configurados al inicio y tareas programadas activas. |
| `09_LoggingYSeguridad.ps1` | Logs y auditoría de seguridad | Consulta política de auditoría, logs principales y eventos de seguridad recientes. |
| `10_RecursosCompartidosYSMB.ps1` | Recursos compartidos y SMB | Revisa recursos compartidos, permisos SMB y configuración del protocolo SMB. |

## Requisitos

- Sistema operativo Windows.
- PowerShell.
- Permisos de administrador para obtener resultados completos.
- Algunos comandos pueden requerir ediciones específicas de Windows, especialmente BitLocker.

## Uso

Ejecutar PowerShell como administrador y correr cada script individualmente:

```powershell
.\01_Actualizaciones.ps1
.\02_BitLocker.ps1
.\03_Usuarios.ps1
