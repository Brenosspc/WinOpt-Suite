@echo off
:MENU
cls
color 0A
echo ===================================================
echo          WinOpt - Suite de Manutencao Windows
echo ===================================================
echo --- SEGURANCA ---
echo [1] Criar Ponto de Restauracao do Windows
echo.
echo --- DIAGNOSTICOS ---
echo [2] Diagnostico Rapido de RAM (Top Processos)
echo [3] Investigacao Avancada de RAM (Kernel/Drivers)
echo [4] Diagnostico de Hardware e Saude dos Discos
echo [5] Gerar Relatorio Completo de Bateria (Notebook)
echo.
echo --- OTIMIZACAO E CORRECAO ---
echo [6] Limpar Cache Standby (RAMMap)
echo [7] Otimizar Sistema (SysMain / Explorer / GC)
echo [8] Corrigir Vazamento NDU (Kernel/Driver de Rede)
echo [9] Limpeza de Arquivos Temporarios e Lixeira
echo [10] Reparo de Arquivos do Windows (SFC / DISM)
echo [11] Redefinir Rede e Limpar DNS
echo.
echo --- FERRAMENTAS ---
echo [12] Editar Codigo-Fonte do Menu
echo [13] Sair
echo ===================================================
set /p opcao=Escolha uma opcao [1-13]: 

if "%opcao%"=="1" goto OP1
if "%opcao%"=="2" goto OP2
if "%opcao%"=="3" goto OP3
if "%opcao%"=="4" goto OP4
if "%opcao%"=="5" goto OP5
if "%opcao%"=="6" goto OP6
if "%opcao%"=="7" goto OP7
if "%opcao%"=="8" goto OP8
if "%opcao%"=="9" goto OP9
if "%opcao%"=="10" goto OP10
if "%opcao%"=="11" goto OP11
if "%opcao%"=="12" goto OP12
if "%opcao%"=="13" goto SAIR

:OP1
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp09-Fix-Criar-Ponto-Restauracao.ps1"
pause
goto MENU

:OP2
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp01-Diag-RAM-Rapido.ps1"
pause
goto MENU

:OP3
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp02-Diag-RAM-Avancado.ps1"
pause
goto MENU

:OP4
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp08-Diag-Hardware-Disco.ps1"
pause
goto MENU

:OP5
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp010-Diag-Relatorio-Bateria.ps1"
pause
goto MENU

:OP6
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp04-Fix-Limpar-Cache-RAM.ps1"
pause
goto MENU

:OP7
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp03-Fix-Otimizar-RAM.ps1"
pause
goto MENU

:OP8
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f
echo.
echo O NDU foi desativado! REINICIE o computador para aplicar a solucao.
pause
goto MENU

:OP9
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp05-Fix-Limpeza-Disco-Temp.ps1"
pause
goto MENU

:OP10
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp06-Fix-Reparo-Sistema-SFC.ps1"
pause
goto MENU

:OP11
cls
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp07-Fix-Reset-Rede-DNS.ps1"
pause
goto MENU

:OP12
cls
echo Abrindo o codigo-fonte do MENU-SUPORTE no Bloco de Notas...
notepad.exe "%~f0"
goto MENU

:SAIR
exit