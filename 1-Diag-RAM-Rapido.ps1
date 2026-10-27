if ($MyInvocation.MyCommand.Definition) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
} else {
    $ScriptDir = Get-Location
}

$LogDir = Join-Path -Path $ScriptDir -ChildPath "Logs"

if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

$ComputerName = $env:COMPUTERNAME
$TimeStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$LogFile = Join-Path -Path $LogDir -ChildPath "Diag_Rapido_${ComputerName}_${TimeStamp}.txt"

Start-Transcript -Path $LogFile -Force | Out-Null

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   DIAGNOSTICO RAPIDO DE MEMORIA RAM      " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Computador : $ComputerName" -ForegroundColor Gray
Write-Host " Data/Hora  : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -ForegroundColor Gray
Write-Host "==========================================" -ForegroundColor Cyan

$OS = Get-CimInstance Win32_OperatingSystem
$TotalRAM = [math]::Round($OS.TotalVisibleMemorySize / 1MB, 2)
$FreeRAM  = [math]::Round($OS.FreePhysicalMemory / 1MB, 2)
$UsedRAM  = [math]::Round($TotalRAM - $FreeRAM, 2)
$Percent  = [math]::Round(($UsedRAM / $TotalRAM) * 100, 1)

Write-Host "`n[+] Uso Total da RAM:" -ForegroundColor Yellow
if ($Percent -lt 70) {
    Write-Host "    [STATUS DA MEMORIA]: SAUDAVEL - $UsedRAM GB de $TotalRAM GB ($Percent%)" -ForegroundColor Green
} elseif ($Percent -le 85) {
    Write-Host "    [STATUS DA MEMORIA]: ATENCAO - $UsedRAM GB de $TotalRAM GB ($Percent%)" -ForegroundColor Yellow
} else {
    Write-Host "    [STATUS DA MEMORIA]: CRITICO - $UsedRAM GB de $TotalRAM GB ($Percent%)" -ForegroundColor Red
}

Write-Host "`n[+] Top 10 Aplicacoes/Processos por Consumo Total de RAM:" -ForegroundColor Yellow
Get-Process | Group-Object ProcessName | Select-Object @{Name="Processo"; Expression={$_.Name}},
    @{Name="Instancias"; Expression={$_.Count}},
    @{Name="RAM_Total_MB"; Expression={[math]::Round(($_.Group | Measure-Object WorkingSet64 -Sum).Sum / 1MB, 1)}} |
    Sort-Object RAM_Total_MB -Descending | Select-Object -First 10 | Out-String | Write-Host

$Browsers = @('chrome', 'msedge', 'firefox', 'opera', 'brave')
$RunningBrowsers = Get-Process | Where-Object { $Browsers -contains $_.ProcessName }

if ($RunningBrowsers) {
    Write-Host "[+] Detalhamento de Navegadores Abertos:" -ForegroundColor Yellow
    $RunningBrowsers | Group-Object ProcessName | ForEach-Object {
        $BrowserName = $_.Name
        $Count = $_.Count
        $RAM = [math]::Round(($_.Group | Measure-Object WorkingSet64 -Sum).Sum / 1MB, 1)
        Write-Host "    -> ${BrowserName}: $Count processos/abas abertos consumindo $RAM MB" -ForegroundColor Cyan
    }
} else {
    Write-Host "[+] Nenhum navegador principal detectado em execucao." -ForegroundColor DarkGray
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "Log salvo com sucesso em: $LogFile" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan

Stop-Transcript | Out-Null