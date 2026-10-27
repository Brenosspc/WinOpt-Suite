Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Execute como ADMINISTRADOR.", "Acesso Negado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "    LIMPEZA DE ARQUIVOS TEMPORARIOS      " -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow

# Salvar tamanho antes da limpeza
$DiskBefore = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB

Write-Host "`n[+] Esvaziando Lixeira..." -ForegroundColor Cyan
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "[+] Limpando pastas Temp do Sistema e Usuario..." -ForegroundColor Cyan
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "[+] Limpando cache do Windows Update (SoftwareDistribution)..." -ForegroundColor Cyan
Stop-Service -Name "wuauserv" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name "wuauserv" -ErrorAction SilentlyContinue

$DiskAfter = (Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB
$GainedGB = [math]::Round($DiskAfter - $DiskBefore, 2)

[System.Windows.Forms.MessageBox]::Show("Limpeza de disco concluida!`n`nEspaco liberado em C: cerca de $GainedGB GB.", "Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null