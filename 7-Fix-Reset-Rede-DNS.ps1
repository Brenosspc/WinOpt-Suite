Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Execute como ADMINISTRADOR.", "Acesso Negado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "    REDEFINICAO DE PILHA DE REDE E DNS    " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host "`n[+] Limpando Cache DNS..." -ForegroundColor Yellow
ipconfig /flushdns

Write-Host "[+] Redefinindo Winsock e Catálogo IP..." -ForegroundColor Yellow
netsh winsock reset | Out-Null
netsh int ip reset | Out-Null

[System.Windows.Forms.MessageBox]::Show("Pilha de rede e DNS redefinidos com sucesso!`n`nRecomenda-se reiniciar a maquina.", "Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null