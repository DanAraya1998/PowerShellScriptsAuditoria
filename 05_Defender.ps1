Write-Host "==============================================="
Write-Host "SCRIPT 05 - MICROSOFT DEFENDER"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

try {
    Write-Host "`nEstado general de Microsoft Defender:`n"

    Get-MpComputerStatus |
    Select-Object AMServiceEnabled,
                  AntivirusEnabled,
                  AntispywareEnabled,
                  RealTimeProtectionEnabled,
                  BehaviorMonitorEnabled,
                  IoavProtectionEnabled,
                  NISEnabled,
                  IsTamperProtected,
                  AntivirusSignatureLastUpdated,
                  QuickScanEndTime,
                  FullScanEndTime |
    Format-List

    Write-Host "`nPreferencias relevantes de Defender:`n"

    Get-MpPreference |
    Select-Object DisableRealtimeMonitoring,
                  DisableBehaviorMonitoring,
                  DisableIOAVProtection,
                  MAPSReporting,
                  SubmitSamplesConsent,
                  ExclusionPath,
                  ExclusionProcess,
                  ExclusionExtension,
                  AttackSurfaceReductionRules_Ids,
                  AttackSurfaceReductionRules_Actions |
    Format-List
}
catch {
    Write-Host "No se pudo consultar Microsoft Defender."
}