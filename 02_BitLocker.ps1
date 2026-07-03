Write-Host "==============================================="
Write-Host "SCRIPT 02 - AUDITORÍA DE BITLOCKER"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

try {
    Get-BitLockerVolume |
    Select-Object MountPoint,
                  VolumeStatus,
                  ProtectionStatus,
                  EncryptionPercentage,
                  LockStatus,
                  EncryptionMethod |
    Format-Table -AutoSize
}
catch {
    Write-Host "No se pudo consultar BitLocker."
    Write-Host "Puede que esta edición de Windows no lo soporte o que falten privilegios."
}