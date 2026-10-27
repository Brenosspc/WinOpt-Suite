# 🧰 WinOpt - Suite — Windows Maintenance & Diagnostic Toolkit

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=flat-square&logo=powershell)
![Windows](https://img.shields.io/badge/OS-Windows_10%2F11-0078D6?style=flat-square&logo=windows)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

### 📌 Sobre o Projeto
O **WinOpt - Suite** é um conjunto modular e portátil de scripts em PowerShell e Batch projetado para automação de tarefas de suporte técnico, otimização de memória RAM, diagnóstico de kernel e manutenção preventiva em ambientes Windows.

Desenvolvido para execução direta via pendrive/USB, o toolkit permite intervenções rápidas e gera logs de diagnóstico locais sem depender de instalações no sistema do cliente.

---

### ⚡ Funcionalidades
* **🛡️ Segurança:** Criação automática de Ponto de Restauração antes de aplicar otimizações.
* **🔍 Diagnósticos Rápidos:** Mapeamento do consumo global de RAM, top 10 processos críticos e uso por navegadores.
* **🧠 Investigação de Kernel:** Mapeamento de *Non-Paged Pool* e *Paged Pool* para isolar vazamentos de memória por drivers.
* **🧹 Otimização de RAM:** Limpeza de cache *Standby* via `RAMMap` sem encerrar sessões de usuários.
* **🔧 Correção de Drivers:** Desativação do driver `NDU` via Registro para estancar vazamentos no kernel.
* **🧰 Manutenção de Sistema:** Reparo automatizado via `SFC /scannow` e `DISM`, limpeza de temporários/lixeira e reset de pilha de rede/DNS.
* **🔋 Relatórios de Bateria:** Geração automática do relatório oficial do Windows (`powercfg /batteryreport`) em HTML.

---

### 📁 Estrutura do Repositório
🚀 Como Usar
Obter os Arquivos:
Clone este repositório ou faça o download como .zip, extraindo o conteúdo na raiz do seu pendrive:

Bash
git clone [https://github.com/Brenosspc/WinOpt-Suite.git](https://github.com/Brenosspc/WinOpt-Suite.git)
Dependências Opcionais (RAMMap):

Baixe o utilitário oficial RAMMap.exe no site da Microsoft Sysinternals.

Cole o arquivo RAMMap.exe diretamente na pasta raiz do WinOpt - Suite (necessário apenas se for utilizar a opção de limpeza de cache Standby RAM).

Execução em Campo:

Conecte o pendrive na máquina do cliente.

Clique com o botão direito no arquivo MENU-SUPORTE.bat e selecione "Executar como Administrador".

Escolha a opção desejada no painel numérico do menu e pressione Enter.

Nota: Todos os diagnósticos e relatórios gerados pelos scripts serão gravados automaticamente na pasta Logs/ dentro da própria suíte.

📝 Licença
```text
📂 WinOpt - Suite/
├── 📄 MENU-SUPORTE.bat                  # Menu principal em Batch
├── 📄 1-Diag-RAM-Rapido.ps1             # Análise rápida de memória RAM
├── 📄 2-Diag-RAM-Avancado.ps1           # Investigação de Kernel/Drivers
├── 📄 3-Fix-Otimizar-RAM.ps1            # Otimização de SysMain e Explorer
├── 📄 4-Fix-Limpar-Cache-RAM.ps1        # Automação via RAMMap (Standby Cache)
├── 📄 5-Fix-Limpeza-Disco-Temp.ps1      # Limpeza de arquivos temporários e lixeira
├── 📄 6-Fix-Reparo-Sistema-SFC.ps1      # Reparo SFC e DISM
├── 📄 7-Fix-Reset-Rede-DNS.ps1          # Reset de rede, Winsock e Flush DNS
├── 📄 8-Diag-Hardware-Disco.ps1         # Diagnóstico de armazenamento/discos
├── 📄 9-Fix-Criar-Ponto-Restauracao.ps1 # Criação de ponto de restauração
├── 📄 10-Diag-Relatorio-Bateria.ps1     # Gerador de relatório de bateria
└── 📂 Logs/                             # Logs de execução gerados automaticamente
```

🚀 Como Usar
Obter os Arquivos:
Clone este repositório ou faça o download como .zip, extraindo o conteúdo na raiz do seu pendrive:

- Bash
git clone [https://github.com/Brenosspc/WinOpt-Suite.git](https://github.com/Brenosspc/WinOpt-Suite.git)
Dependências Opcionais (RAMMap):

- Baixe o utilitário oficial RAMMap.exe no site da Microsoft Sysinternals.

- Cole o arquivo RAMMap.exe diretamente na pasta raiz do WinOpt - Suite (necessário apenas se for utilizar a opção de limpeza de cache Standby RAM).


Execução em Campo:

- Conecte o pendrive na máquina do cliente.

- Clique com o botão direito no arquivo MENU-SUPORTE.bat e selecione "Executar como Administrador".

- Escolha a opção desejada no painel numérico do menu e pressione Enter.

Nota: Todos os diagnósticos e relatórios gerados pelos scripts serão gravados automaticamente na pasta Logs/ dentro da própria suíte.
