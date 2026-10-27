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
$LogFile = Join-Path -Path $LogDir -ChildPath "Diag_Avancado_${ComputerName}_${TimeStamp}.txt"

Start-Transcript -Path $LogFile -Force | Out-Null

Write-Host "==========================================" -ForegroundColor Magenta
Write-Host "   INVESTIGACAO AVANCADA DE VAZAMENTOS   " -ForegroundColor Magenta
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host " Computador : $ComputerName" -ForegroundColor Gray
Write-Host " Data/Hora  : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -ForegroundColor Gray
Write-Host "==========================================" -ForegroundColor Magenta

$Perf = Get-CimInstance Win32_PerfFormattedData_PerfOS_Memory
$NonPagedMB = [math]::Round($Perf.PoolNonpagedBytes / 1MB, 1)
$PagedMB    = [math]::Round($Perf.PoolPagedBytes / 1MB, 1)
$CacheMB    = [math]::Round($Perf.CacheBytes / 1MB, 1)

Write-Host "`n[+] Memoria de Sistema / Kernel:" -ForegroundColor Yellow
Write-Host "    Paged Pool (Memoria Paginada de Kernel)      : $PagedMB MB"
Write-Host "    System Cache (Cache de Leitura do SO)        : $CacheMB MB"

if ($NonPagedMB -gt 900) {
    Write-Host "    [DRIVERS/KERNEL]: CRITICO - $NonPagedMB MB - VAZAMENTO DE MEMORIA DETECTADO (Driver de rede/antivirus)." -ForegroundColor Red
} elseif ($NonPagedMB -gt 600) {
    Write-Host "    [DRIVERS/KERNEL]: ATENCAO - $NonPagedMB MB - Uso de kernel moderado/alto." -ForegroundColor Yellow
} else {
    Write-Host "    [DRIVERS/KERNEL]: OK - $NonPagedMB MB - Sem indicios de vazamento em drivers." -ForegroundColor Green
}

$Pagefile = Get-CimInstance Win32_PageFileUsage
if ($Pagefile) {
    Write-Host "`n[+] Arquivo de Paginacao (Pagefile.sys):" -ForegroundColor Yellow
    foreach ($pf in $Pagefile) {
        $Allocated = $pf.AllocatedBaseSize
        $Current = $pf.CurrentUsage
        $PercentPF = [math]::Round(($Current / $Allocated) * 100, 1)
        if ($PercentPF -gt 80) {
            Write-Host "    [PAGEFILE/SWAP]: CRITICO - $Current MB de $Allocated MB ($PercentPF%)" -ForegroundColor Red
        } else {
            Write-Host "    [PAGEFILE/SWAP]: OK - $Current MB de $Allocated MB ($PercentPF%)" -ForegroundColor Green
        }
    }
}

Write-Host "`n==========================================" -ForegroundColor Magenta
Write-Host "Log salvo com sucesso em: $LogFile" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Magenta

Stop-Transcript | Out-Null