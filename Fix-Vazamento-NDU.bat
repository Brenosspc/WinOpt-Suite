@echo off
:: Verifica permissões de Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ===================================================
    echo  ERRO: Execute este script como ADMINISTRADOR!
    echo ===================================================
    echo.
    pause
    exit
)

cls
color 0C
echo ===================================================
echo   CORRECAO DE VAZAMENTO DE KERNEL (SERVICO NDU)
echo ===================================================
echo.
echo Desativando o servico NDU (Network Data Usage)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f >nul

if %errorlevel% equ 0 (
    echo.
    echo [SUCESSO] O servico NDU foi desativado no Registro!
    echo.
    echo IMPORTANTE: O Nonpaged Pool de kernel so sera esvaziado
    echo apos REINICIAR o computador.
    echo.
) else (
    echo.
    echo [ERRO] Nao foi possivel alterar a chave no Registro.
    echo.
)

pause