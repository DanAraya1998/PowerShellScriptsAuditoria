Write-Host "==============================================="
Write-Host "SCRIPT 06 - FIREWALL Y PERFIL DE RED"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nEstado de perfiles del Firewall de Windows:`n"

Get-NetFirewallProfile |
Select-Object Name,
              Enabled,
              DefaultInboundAction,
              DefaultOutboundAction,
              AllowInboundRules,
              NotifyOnListen |
Format-Table -AutoSize

Write-Host "`nPerfil de red activo:`n"

Get-NetConnectionProfile |
Select-Object Name,
              InterfaceAlias,
              NetworkCategory,
              IPv4Connectivity,
              IPv6Connectivity |
Format-Table -AutoSize

Write-Host "`nPrimeras reglas entrantes permitidas y habilitadas:`n"

$Reglas = Get-NetFirewallRule |
Where-Object {
    $_.Enabled -eq "True" -and
    $_.Direction -eq "Inbound" -and
    $_.Action -eq "Allow"
}

Write-Host "Cantidad de reglas entrantes permitidas: $($Reglas.Count)`n"

$Reglas |
Select-Object -First 15 DisplayName, Profile, Direction, Action, Enabled |
Format-Table -AutoSize