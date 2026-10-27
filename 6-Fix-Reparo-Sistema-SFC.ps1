Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Execute como ADMINISTRADOR.", "Acesso Negado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Green
Write-Host "   REPARO DE ARQUIVOS DE SISTEMA (SFC/DISM) " -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

Write-Host "`n[1] Executando DISM /RestoreHealth (Recuperando imagem do Windows)..." -ForegroundColor Yellow
dism.exe /Online /Cleanup-Image /RestoreHealth

Write-Host "`n[2] Executando SFC /ScanNow (Corrigindo arquivos protegidos)..." -ForegroundColor Yellow
sfc.exe /scannow

[System.Windows.Forms.MessageBox]::Show("Verificacao e reparo de arquivos concluida!", "Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null