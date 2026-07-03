Write-Host "==============================================="
Write-Host "SCRIPT 03 - USUARIOS Y ADMINISTRADORES LOCALES"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nUsuarios locales encontrados:`n"

Get-LocalUser |
Select-Object Name,
              Enabled,
              LastLogon,
              PasswordRequired,
              PasswordLastSet,
              UserMayChangePassword |
Format-Table -AutoSize

Write-Host "`nMiembros del grupo de administradores locales:`n"

$GrupoAdministradores = ([System.Security.Principal.SecurityIdentifier]"S-1-5-32-544").
Translate([System.Security.Principal.NTAccount]).Value.Split("\")[-1]

Get-LocalGroupMember -Group $GrupoAdministradores |
Select-Object Name, ObjectClass, PrincipalSource |
Format-Table -AutoSize