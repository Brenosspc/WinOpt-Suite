Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Este script precisa ser executado como ADMINISTRADOR.", "Acesso Negado - Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Green
Write-Host "    OTIMIZACAO E LIMPEZA DE MEMORIA RAM   " -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

Write-Host "`n[1] Reiniciando servico SysMain..." -ForegroundColor Yellow
Stop-Service -Name "SysMain" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2
Start-Service -Name "SysMain" -ErrorAction SilentlyContinue

Write-Host "`n[2] Solicitando coleta de lixo do sistema..." -ForegroundColor Yellow
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

Write-Host "`n[3] Reiniciando o processo Windows Explorer..." -ForegroundColor Yellow
Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process "explorer.exe"

[System.Windows.Forms.MessageBox]::Show("Otimizacao de sistema concluida com sucesso!`n`nServicos de cache e Explorer reiniciados.", "Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null

Write-Host "`n==========================================" -ForegroundColor Green