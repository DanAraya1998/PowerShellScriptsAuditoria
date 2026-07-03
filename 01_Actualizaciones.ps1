Write-Host "==============================================="
Write-Host "SCRIPT 01 - ACTUALIZACIONES"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="
Write-Host "`nBúsqueda de actualizaciones pendientes:`n"
try {
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
    $ResultadoBusqueda = $UpdateSearcher.Search("IsInstalled=0 and Type='Software'")
    $Pendientes = $ResultadoBusqueda.Updates
    Write-Host "Cantidad de actualizaciones pendientes: $($Pendientes.Count)`n"
    if ($Pendientes.Count -gt 0) {
        $ResultadoPendientes = foreach ($Update in $Pendientes) {
            $Categorias = @()
            foreach ($Categoria in $Update.Categories) {
                $Categorias += $Categoria.Name
            }
            $KBs = @()
            foreach ($KB in $Update.KBArticleIDs) {
                $KBs += "KB$KB"
            }
            $ClasificacionEstimada = if ($Update.Title -match "seguridad|security|defender|malicious|malintencionado") {
                "Seguridad"
            }
            elseif ($Update.Title -match ".NET|Framework") {
                "Componente / Framework"
            }
            else {
                "General"
            }
            [PSCustomObject]@{
                Titulo                = $Update.Title
                KB                    = if ($KBs.Count -gt 0) { $KBs -join ", " } else { "No disponible" }
                SeveridadMSRC         = if ($Update.MsrcSeverity) { $Update.MsrcSeverity } else { "No especificada por Windows Update" }
                ClasificacionEstimada = $ClasificacionEstimada
            }
        }
        $ResultadoPendientes | Format-Table -AutoSize
    }
    else {
        Write-Host "No se encontraron actualizaciones pendientes."
    }
}
catch {
    Write-Host "No se pudieron consultar actualizaciones pendientes."
    Write-Host "Detalle del error:"
    Write-Host $_.Exception.Message
}