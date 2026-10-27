Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Este script precisa ser executado como ADMINISTRADOR.", "Acesso Negado - Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "    LIMPEZA DE MEMORIA STANDBY / CACHE    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$OSBefore = Get-CimInstance Win32_OperatingSystem
$FreeBefore = [math]::Round($OSBefore.FreePhysicalMemory / 1MB, 2)

if ($MyInvocation.MyCommand.Definition) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
} else {
    $ScriptDir = Get-Location
}

$RAMMapPath = Join-Path -Path $ScriptDir -ChildPath "RAMMap.exe"

if (-not (Test-Path $RAMMapPath)) {
    $RAMMapPath = Join-Path -Path $ScriptDir -ChildPath "RAMMap64.exe"
}

if (Test-Path $RAMMapPath) {
    Start-Process -FilePath $RAMMapPath -ArgumentList "-Empty StandbyList" -NoNewWindow -Wait
    Start-Process -FilePath $RAMMapPath -ArgumentList "-Empty WorkingSet" -NoNewWindow -Wait
    Start-Sleep -Seconds 2

    $OSAfter = Get-CimInstance Win32_OperatingSystem
    $FreeAfter = [math]::Round($OSAfter.FreePhysicalMemory / 1MB, 2)
    $Gained = [math]::Round($FreeAfter - $FreeBefore, 2)

    if ($Gained -gt 0) {
        $UserMessage = "Otimizacao de memoria concluida!`n`nForam liberados cerca de $Gained GB de memoria RAM em cache.`n`nSeus programas ativos continuam abertos."
    } else {
        $UserMessage = "Verificacao concluida!`n`nA memoria RAM em cache ja estava otimizada."
    }

    [System.Windows.Forms.MessageBox]::Show($UserMessage, "Otimizacao de Memoria - Suporte", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null
} else {
    [System.Windows.Forms.MessageBox]::Show("O executavel RAMMap.exe nao foi encontrado na raiz do pendrive.", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning) | Out-Null
}

Write-Host "`n==========================================" -ForegroundColor Cyan