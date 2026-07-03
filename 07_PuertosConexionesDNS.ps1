Write-Host "==============================================="
Write-Host "SCRIPT 07 - PUERTOS, CONEXIONES Y DNS"
Write-Host "Equipo: $env:COMPUTERNAME"
Write-Host "Fecha: $(Get-Date)"
Write-Host "==============================================="

Write-Host "`nPuertos TCP en escucha:`n"

$PuertosEscucha = Get-NetTCPConnection -State Listen |
Select-Object LocalAddress,
              LocalPort,
              OwningProcess,
              @{Name="Proceso";Expression={
                  (Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName
              }} |
Sort-Object LocalPort

Write-Host "Cantidad de puertos en escucha: $($PuertosEscucha.Count)`n"

$PuertosEscucha |
Select-Object -First 20 |
Format-Table -AutoSize

Write-Host "`nConexiones TCP activas:`n"

$ConexionesActivas = Get-NetTCPConnection -State Established |
Select-Object LocalAddress,
              LocalPort,
              RemoteAddress,
              RemotePort,
              OwningProcess,
              @{Name="Proceso";Expression={
                  (Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).ProcessName
              }} |
Sort-Object RemoteAddress

Write-Host "Cantidad de conexiones activas: $($ConexionesActivas.Count)`n"

$ConexionesActivas |
Select-Object -First 20 |
Format-Table -AutoSize

Write-Host "`nPrimeras entradas de caché DNS:`n"

$CacheDNS = Get-DnsClientCache |
Select-Object Entry, RecordType, Data, TimeToLive |
Sort-Object Entry

Write-Host "Cantidad de entradas DNS: $($CacheDNS.Count)`n"

$CacheDNS |
Select-Object -First 20 |
Format-Table -AutoSize