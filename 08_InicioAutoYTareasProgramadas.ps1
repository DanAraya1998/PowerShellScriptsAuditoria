Write-Host "==============================================="
Write-Host "SCRIPT 08 - INICIO AUTOMÁTICO Y TAREAS PROGRAMADAS"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nProgramas configurados para iniciar con Windows:`n"

$ProgramasInicio = Get-CimInstance Win32_StartupCommand |
Select-Object Name, Command, Location, User

Write-Host "Cantidad de programas de inicio: $($ProgramasInicio.Count)`n"

$ProgramasInicio |
Format-Table -AutoSize

Write-Host "`nTareas programadas activas:`n"

$TareasProgramadas = Get-ScheduledTask |
Where-Object { $_.State -ne "Disabled" } |
Select-Object TaskName,
              TaskPath,
              State,
              Author,
              @{Name="Acciones";Expression={
                  ($_.Actions | ForEach-Object { $_.Execute }) -join "; "
              }}

Write-Host "Cantidad de tareas programadas activas: $($TareasProgramadas.Count)`n"

$TareasProgramadas |
Select-Object -First 20 |
Format-Table -AutoSize