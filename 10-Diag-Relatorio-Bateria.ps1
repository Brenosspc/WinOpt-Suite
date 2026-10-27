if ($MyInvocation.MyCommand.Definition) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
} else {
    $ScriptDir = Get-Location
}

$LogDir = Join-Path -Path $ScriptDir -ChildPath "Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir | Out-Null }

$ComputerName = $env:COMPUTERNAME
$TimeStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ReportPath = Join-Path -Path $LogDir -ChildPath "Bateria_${ComputerName}_${TimeStamp}.html"

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "      GERANDO RELATORIO DE BATERIA        " -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow

powercfg /batteryreport /output "$ReportPath"

if (Test-Path $ReportPath) {
    Write-Host "`n[SUCESSO] Relatorio gerado em: $ReportPath" -ForegroundColor Green
    Write-Host "[+] Abrindo o relatorio no navegador..." -ForegroundColor Cyan
    Start-Process "$ReportPath"
} else {
    Write-Host "`n[!] Este dispositivo nao possui bateria ou nao suporta o relatorio." -ForegroundColor Red
}