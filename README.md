# dotfiles — Gentoo + niri

Configuração do meu desktop Gentoo Linux usando [niri](https://github.com/YaLTeR/niri) (compositor
Wayland em scroll/colunas) com uma barra própria feita em [Quickshell](https://quickshell.org/) e
alguns utilitários em C para monitorar o sistema.

## Visão geral

```
niri (compositor)
 ├─ fuzzel        → app launcher (Mod+D)
 ├─ quickshell    → barra superior (workspaces, relógio, cpu/mem, power menu)
 └─ scripts/      → daemons em C que alimentam a barra com dados do sistema
```

Ao iniciar, o niri sobe (ver `spawn-*-at-startup` em `niri/config.kdl`):
- `polkit-mate-authentication-agent-1` — agente de autenticação (senhas gráficas)
- `xwayland-satellite` — suporte a apps X11
- `gentoo-pipewire-launcher` — sobe o PipeWire/áudio
- `qs -c ~/.config/quickshell/bar/` — a barra (Quickshell)
- `swaybg` — wallpaper
- os três binários de `scripts/` (IP externo, uso de CPU, uso de memória)

## Estrutura deste repositório

```
niri/
  config.kdl                         # config principal do niri (input, layout, binds, startup)

fuzzel/
  fuzzel.ini                         # tema/config do launcher fuzzel

scripts/
  vimcompile.sh                      # helper de compilação rápida no vim (c/cpp/lisp/scheme/hs/rust)
  eip/
    externalIp.c                     # consulta o IP público e grava em ~/.rq-scripts/eip/ip
  system-status/
    cpuproc.c                        # calcula % de uso de CPU e grava em .../system-status/cpu
    memproc.c                        # calcula % de uso de memória e grava em .../system-status/mem

quickshell/
  bar/
    shell.qml                        # raiz da barra: conecta ao niri e sobe os sub-processos
    sources/
      modules/                       # widgets que aparecem DENTRO da barra
        bar.qml                      # o PanelWindow da barra em si (junta os módulos abaixo)
        workspaces.qml                # bolinhas de workspace (clicável)
        clock.qml                     # relógio
        systemmonitor.qml             # ícone que abre o popup de CPU/Mem/IP (sources/systemMonitor)
        powermenu.qml                 # ícone que abre o popup de poweroff/reboot (sources/powerMenu)
      systemMonitor/                 # popup separado (processo qs próprio) com CPU/Mem/IP
        shell.qml
        win.qml
      powerMenu/                     # popup separado (processo qs próprio) com poweroff/reboot
        shell.qml
        menu.qml
        poweroff.qml
        reboot.qml
```

## Como as peças se conectam

1. **niri** sobe a barra com `qs -c ~/.config/quickshell/bar/`, que carrega
   `quickshell/bar/shell.qml`.
2. Esse `shell.qml` conecta no IPC do niri (workspace/janela focada) e já deixa registrados dois
   `Process` que **ainda não rodam**: um para `sources/systemMonitor` e outro para
   `sources/powerMenu`. Ele também carrega o componente `Bar` (em `sources/modules/bar.qml`).
3. `sources/modules/bar.qml` monta a barra visual: workspaces à esquerda, nome/id da janela
   focada, e à direita os ícones de CPU/Mem, relógio e power.
4. Ao passar o mouse no ícone de CPU/Mem (`systemmonitor.qml`), ele liga o `Process` `sysMon`
   definido no `shell.qml` pai — isso sobe um **segundo processo Quickshell** independente
   (`sources/systemMonitor`), que lê os arquivos `~/.rq-scripts/system-status/cpu`,
   `.../mem` e `~/.rq-scripts/eip/ip` (escritos pelos binários em C) e mostra um popup.
5. Ao clicar no ícone de power (`powermenu.qml`), o mesmo padrão sobe o processo
   `sources/powerMenu`, que mostra um popup com poweroff/reboot via `sudo`.
6. Os três binários em `scripts/` (compilados a partir dos `.c`) rodam em loop infinito desde o
   startup do niri, escrevendo o IP público e o uso de CPU/memória em arquivos texto simples —
   é assim que o Quickshell "lê" esses dados, sem precisar calcular nada em QML.

## Instalação / uso

> Estes arquivos têm caminhos fixos para o usuário `rq` (ex.: `/home/rq/.rq-scripts/...`).
> Ajuste esses caminhos (ou crie o mesmo usuário/estrutura de pastas) antes de usar.

1. **niri**: copie `niri/config.kdl` para `~/.config/niri/config.kdl`.
2. **fuzzel**: copie `fuzzel/fuzzel.ini` para `~/.config/fuzzel/fuzzel.ini`.
3. **Quickshell**: copie a pasta `quickshell/bar/` para `~/.config/quickshell/bar/`.
4. **Scripts em C**: compile e coloque os binários nos caminhos esperados pelo `config.kdl`:
   ```bash
   mkdir -p ~/.rq-scripts/eip ~/.rq-scripts/system-status
   gcc scripts/eip/externalIp.c        -o ~/.rq-scripts/eip/externalIp
   gcc scripts/system-status/cpuproc.c -o ~/.rq-scripts/system-status/cpuProc -lm
   gcc scripts/system-status/memproc.c -o ~/.rq-scripts/system-status/memProc -lm
   ```
   Dependências: `gcc`, e em tempo de execução `curl` (para o IP externo).
5. Dependências gerais: `niri`, `quickshell` (com o plugin [Niri 0.1](https://github.com/imiric/qml-niri)), `fuzzel`, `swaybg`,
   `swaylock`, `xwayland-satellite`, PipeWire/WirePlumber, `brightnessctl`, `playerctl`,
   fonte **Nerd Font** (JetBrainsMono / CaskaydiaCove) para os ícones da barra.

## Notas / pontos de atenção

- Os três programas em C (`externalIp`, `cpuproc`, `memproc`) rodam em loop infinito com
  `while(1)` e usam caminhos absolutos (`/home/rq/...`) — se for reaproveitar em outra máquina,
  troque esses caminhos por `getenv("HOME")` ou similar.
- `powerMenu` chama `sudo /sbin/poweroff` e `sudo /sbin/reboot` diretamente — normalmente exige
  configurar `sudoers` (NOPASSWD) para esses comandos específicos, senão o clique não vai
  funcionar sem senha.
- Este README documenta apenas a **versão atual** de cada peça. Versões antigas/experimentais
  do Quickshell (uma barra sem power menu, um systemMonitor só com texto em vez de ícones, etc.)
  foram descartadas nesta organização — se quiser recuperá-las, dá pra usar o histórico do git
  depois do primeiro commit.
