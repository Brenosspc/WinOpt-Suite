Add-Type -AssemblyName System.Windows.Forms

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("Execute como ADMINISTRADOR.", "Acesso Negado", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "    CRIANDO PONTO DE RESTAURACAO         " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

try {
    # Habilitar Restauração do Sistema no C: caso esteja desativada
    Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
    
    # Criar Ponto de Restauração
    Checkpoint-Computer -Description "Manutencao Suporte Tecnico" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    
    [System.Windows.Forms.MessageBox]::Show("Ponto de Restauracao criado com sucesso!`n`nNome: Manutencao Suporte Tecnico", "Suporte Tecnico", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null
} catch {
    [System.Windows.Forms.MessageBox]::Show("Nao foi possivel criar o ponto de restauracao.`n`nVerifique se o servico de Restauracao do Sistema esta ativo na maquina.", "Aviso", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning) | Out-Null
}