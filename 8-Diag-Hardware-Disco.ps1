if ($MyInvocation.MyCommand.Definition) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
} else {
    $ScriptDir = Get-Location
}

$LogDir = Join-Path -Path $ScriptDir -ChildPath "Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir | Out-Null }

$ComputerName = $env:COMPUTERNAME
$TimeStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$LogFile = Join-Path -Path $LogDir -ChildPath "Diag_Hardware_${ComputerName}_${TimeStamp}.txt"

Start-Transcript -Path $LogFile -Force | Out-Null

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "      DIAGNOSTICO DE HARDWARE E DISCOS    " -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow

Write-Host "`n[+] Unidades de Armazenamento (Discos / SSDs):" -ForegroundColor Cyan
Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, OperationalStatus, HealthStatus | Format-Table -AutoSize

Write-Host "`n[+] Espaco em Disco (Particoes):" -ForegroundColor Cyan
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID,
    @{Name="Tamanho_GB"; Expression={[math]::Round($_.Size / 1GB, 2)}},
    @{Name="Livre_GB"; Expression={[math]::Round($_.FreeSpace / 1GB, 2)}},
    @{Name="Livre_%"; Expression={[math]::Round(($_.FreeSpace / $_.Size) * 100, 1)}} | Format-Table -AutoSize

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "Log salvo com sucesso em: $LogFile" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Yellow

Stop-Transcript | Out-Null