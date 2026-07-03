Write-Host "==============================================="
Write-Host "SCRIPT 10 - RECURSOS COMPARTIDOS Y SMB"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nRecursos compartidos SMB:`n"

$RecursosCompartidos = Get-SmbShare |
Select-Object Name, Path, Description, ShareState, Special

$RecursosCompartidos |
Format-Table -AutoSize

Write-Host "`nPermisos de recursos compartidos:`n"

foreach ($Share in $RecursosCompartidos) {
    Write-Host "`nRecurso compartido: $($Share.Name)"
    try {
        Get-SmbShareAccess -Name $Share.Name |
        Select-Object AccountName, AccessControlType, AccessRight |
        Format-Table -AutoSize
    }
    catch {
        Write-Host "No se pudieron consultar permisos para este recurso."
    }
}

Write-Host "`nConfiguración SMB del equipo:`n"

Get-SmbServerConfiguration |
Select-Object EnableSMB1Protocol,
              EnableSMB2Protocol,
              RequireSecuritySignature,
              EnableSecuritySignature,
              EncryptData,
              RejectUnencryptedAccess |
Format-List