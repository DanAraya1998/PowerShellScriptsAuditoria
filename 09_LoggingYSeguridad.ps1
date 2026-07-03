Write-Host "==============================================="
Write-Host "SCRIPT 09 - LOGS Y AUDITORÍA DE SEGURIDAD"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nPolítica de auditoría del sistema:`n"

auditpol /get /category:*

Write-Host "`nConfiguración de logs principales:`n"

Get-WinEvent -ListLog Security, System, Application |
Select-Object LogName,
              IsEnabled,
              RecordCount,
              MaximumSizeInBytes,
              LogMode |
Format-Table -AutoSize

Write-Host "`nEventos de seguridad recientes, últimos 7 días:`n"

$EventosSeguridad = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    StartTime = (Get-Date).AddDays(-7)
} -MaxEvents 20 -ErrorAction SilentlyContinue |
Select-Object TimeCreated, Id, ProviderName, LevelDisplayName

$EventosSeguridad |
Format-Table -AutoSize

Write-Host "`nIntentos fallidos de inicio de sesión, últimos 7 días:`n"

$LogonsFallidos = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
    StartTime = (Get-Date).AddDays(-7)
} -ErrorAction SilentlyContinue

Write-Host "Cantidad de intentos fallidos encontrados: $($LogonsFallidos.Count)`n"

$LogonsFallidos |
Select-Object -First 10 TimeCreated, Id, ProviderName |
Format-Table -AutoSize