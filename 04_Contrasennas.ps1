Write-Host "==============================================="
Write-Host "SCRIPT 04 - POLÍTICAS DE CONTRASEÑAS Y CUENTAS"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`n[1] Política local de contraseñas y bloqueo de cuentas:`n"

net accounts

Write-Host "`n[2] Configuración de seguridad local relacionada con contraseñas:`n"

$TempFile = "$env:TEMP\politica_seguridad_local.inf"

secedit /export /cfg $TempFile | Out-Null

$Politica = Get-Content $TempFile

$Claves = @(
    "MinimumPasswordAge",
    "MaximumPasswordAge",
    "MinimumPasswordLength",
    "PasswordComplexity",
    "PasswordHistorySize",
    "LockoutBadCount",
    "ResetLockoutCount",
    "LockoutDuration",
    "ClearTextPassword"
)

$ResultadoPolitica = foreach ($Clave in $Claves) {

    $Linea = $Politica | Where-Object { $_ -match "^$Clave\s*=" }

    if ($Linea) {

        $Partes = $Linea -split "="
        $Nombre = $Partes[0].Trim()
        $Valor = $Partes[1].Trim()

        switch ($Nombre) {
            "MinimumPasswordAge" {
                $Descripcion = "Edad mínima de contraseña en días"
            }
            "MaximumPasswordAge" {
                $Descripcion = "Edad máxima de contraseña en días"
            }
            "MinimumPasswordLength" {
                $Descripcion = "Longitud mínima de contraseña"
            }
            "PasswordComplexity" {
                $Descripcion = if ($Valor -eq "1") { "Complejidad habilitada" } else { "Complejidad deshabilitada" }
            }
            "PasswordHistorySize" {
                $Descripcion = "Cantidad de contraseñas recordadas"
            }
            "LockoutBadCount" {
                $Descripcion = "Intentos fallidos antes de bloqueo"
            }
            "ResetLockoutCount" {
                $Descripcion = "Tiempo para reiniciar contador de bloqueo"
            }
            "LockoutDuration" {
                $Descripcion = "Duración del bloqueo de cuenta"
            }
            "ClearTextPassword" {
                $Descripcion = if ($Valor -eq "0") { "No almacena contraseña reversible" } else { "Almacena contraseña reversible" }
            }
        }

        [PSCustomObject]@{
            Configuracion  = $Nombre
            Valor          = $Valor
            Interpretacion = $Descripcion
        }
    }
}

$ResultadoPolitica | Format-Table -AutoSize


Write-Host "`n[3] Revisión de usuarios locales y requisitos de contraseña:`n"

Get-LocalUser |
Select-Object Name,
              Enabled,
              PasswordRequired,
              PasswordLastSet,
              UserMayChangePassword,
              PasswordExpires |
Format-Table -AutoSize

function Obtener-ValorPolitica {
    param (
        [string]$NombreClave
    )

    $Linea = $Politica | Where-Object { $_ -match "^$NombreClave\s*=" }

    if ($Linea) {
        return (($Linea -split "=")[1]).Trim()
    }
    else {
        return $null
    }
}



Write-Host "`n[4] Cuentas locales sin requisito de contraseña:`n"

$UsuariosSinPassword = Get-LocalUser | Where-Object {
    $_.PasswordRequired -eq $false -and $_.Enabled -eq $true
}

if ($UsuariosSinPassword) {
    $UsuariosSinPassword |
    Select-Object Name, Enabled, PasswordRequired, LastLogon |
    Format-Table -AutoSize
}
else {
    Write-Host "No se encontraron cuentas activas sin requisito de contraseña."
}

Write-Host "`nAuditoría de políticas de contraseñas finalizada."