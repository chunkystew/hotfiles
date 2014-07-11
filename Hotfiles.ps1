# Written by Matthew Saunier, 11 Jun 2014. Licensed under the GPL, version 3.
$Minus7 = (Get-Date).AddDays(-7)
$Minus14 = (Get-Date).AddDays(-14)
$Minus30 = (Get-Date).AddDays(-30)
$Count = 0
$ByteTotal = 0
$Byte7Read = 0
$Byte7Write = 0
$Byte14Read = 0
$Byte14Write = 0
$Byte30Read = 0
$Byte30Write = 0
Get-ChildItem -recurse -EA SilentlyContinue | Select-Object LastAccessTime, LastWriteTime, Length | ForEach-Object {
    if ( $_.Length -gt 0 ) {
        $ByteTotal += $_.Length
        $Count++
        if ($_.LastAccessTime -gt $Minus30) { 
            $Byte30Read += $_.Length
            if ($_.LastAccessTime -gt $Minus14) { 
                $Byte14Read += $_.Length
                if ($_.LastAccessTime -gt $Minus7) { 
                    $Byte7Read += $_.Length } } }
        if ($_.LastWriteTime -gt $Minus30) { 
            $Byte30Write += $_.Length
            if ($_.LastWriteTime -gt $Minus14) { 
                $Byte14Write += $_.Length
                if ($_.LastWriteTime -gt $Minus7) { 
                    $Byte7Write += $_.Length } } } } }
Write-Host
Write-Host Total MB: ([Math]::Floor([decimal]$ByteTotal / 1024 / 1024))
Write-Host File Count: $Count
Write-Host
Write-Host === Last 7 days ===
Write-Host
Write-Host Accessed: ([Math]::Floor([decimal]$Byte7Read / 1024 / 1024))
Write-Host Written: ([Math]::Floor([decimal]$Byte7Write / 1024 / 1024))
Write-Host
Write-Host === Last 14 days ===
Write-Host
Write-Host Accessed: ([Math]::Floor([decimal]$Byte14Read / 1024 / 1024))
Write-Host Written: ([Math]::Floor([decimal]$Byte14Write / 1024 / 1024))
Write-Host
Write-Host === Last 30 days ===
Write-Host
Write-Host Accessed: ([Math]::Floor([decimal]$Byte30Read / 1024 / 1024))
Write-Host Written: ([Math]::Floor([decimal]$Byte30Write / 1024 / 1024))
Write-Host
