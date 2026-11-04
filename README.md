# Mi configuración de Neovim (NvChad)

Configuración personal sobre [NvChad](https://github.com/NvChad/NvChad) v2.5, que se usa como plugin (`NvChad/NvChad` + `import = "nvchad.plugins"`). Tema `ayu_light` con transparencia.

> La config anterior (vim-plug / `init.vim`, 2022) se conserva en la rama [`backup-vim-plug`](../../tree/backup-vim-plug).

## Instalación

Requisitos: Neovim ≥ 0.11, `git`, un [Nerd Font](https://www.nerdfonts.com/) y, para la integración con Claude, el CLI [`claude`](https://claude.com/claude-code) en el `PATH`.

```bash
# respalda tu config actual si existe
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/niczapata/nvim ~/.config/nvim
nvim
```

Dentro de Neovim:

1. `:Lazy sync` instala los plugins.
2. `:MasonToolsUpdate` instala LSP y formateadores.
3. `:lua require('base46').load_all_highlights()` regenera el tema si ves colores raros.

## Estructura

| Archivo | Contenido |
|---|---|
| `init.lua` | Bootstrap de lazy.nvim e import de NvChad y `plugins/` |
| `lua/chadrc.lua` | Tema, tabufline y statusline con extremos redondeados |
| `lua/options.lua` | Opciones: portapapeles, wrap, cursor, `.txt` como markdown |
| `lua/mappings.lua` | Atajos propios (multi-cursor, opencode, windsurf) |
| `lua/plugins/init.lua` | Plugins generales |
| `lua/plugins/claudecode.lua` | Integración con Claude Code |
| `lua/plugins/bullets.lua` | Listas estilo Word en markdown y texto |
| `lua/configs/conform.lua` | Formateadores por filetipo |
| `lua/configs/lspconfig.lua` | Servidores LSP |
| `lua/configs/lists.lua` | Opciones compartidas de listas y `dd` que renumera |
| `after/ftplugin/{markdown,text}.lua` | Aplican `configs.lists` tras el ftplugin nativo |

## Plugins añadidos

- [claudecode.nvim](https://github.com/coder/claudecode.nvim): Claude Code en un panel a la izquierda.
- [opencode.nvim](https://github.com/NickvanDyke/opencode.nvim) y [snacks.nvim](https://github.com/folke/snacks.nvim).
- [noice.nvim](https://github.com/folke/noice.nvim): cmdline como popup centrado.
- [multiple-cursors.nvim](https://github.com/brenton-leighton/multiple-cursors.nvim).
- [windsurf.vim](https://github.com/Exafunction/windsurf.vim): autocompletado con IA.
- [bullets.vim](https://github.com/bullets-vim/bullets.vim): continúa viñetas y numeración.
- [conform.nvim](https://github.com/stevearc/conform.nvim): formato al guardar.
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim): instala LSP y formateadores.
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) a la derecha y treesitter en la rama `master`.

## LSP y formateadores

| Lenguaje | LSP | Formateador |
|---|---|---|
| HTML | `html` | `prettier` |
| CSS | `cssls` | `prettier` |
| Python | `pyright` | `black` |
| LaTeX | `texlab` | `latexindent` |
| Lua | (NvChad) | `stylua` |

## Atajos

`<leader>` es la barra espaciadora.

### Claude Code (`<leader>c`)

| Tecla | Modo | Acción |
|---|---|---|
| `<leader>cc` | n | Abrir / cerrar Claude |
| `<leader>cf` | n | Enfocar la ventana de Claude |
| `<leader>cr` | n | Reanudar una sesión |
| `<leader>cC` | n | Continuar la última sesión |
| `<leader>cM` | n | Elegir modelo |
| `<leader>cb` | n | Añadir el buffer actual al contexto |
| `<leader>cs` | v | Enviar la selección a Claude |
| `<leader>cs` | n (nvim-tree) | Añadir el archivo bajo el cursor |
| `<leader>ca` | n | Aceptar diff |
| `<leader>cd` | n | Rechazar diff |

Para moverte entre Claude y el editor: `Ctrl-x` sale del modo terminal, `Ctrl-h` / `Ctrl-l` cambian de ventana e `i` vuelve a escribir en Claude.

### Generales

| Tecla | Modo | Acción |
|---|---|---|
| `;` | n | Abre el cmdline (como `:`) |
| `jk` | i | Salir a modo normal |
| `zj` / `zk` | n | Añadir línea vacía debajo / encima sin mover el cursor |

### Multi-cursor

| Tecla | Modo | Acción |
|---|---|---|
| `Ctrl-j` / `Ctrl-k` | n, x | Añadir cursor abajo / arriba |
| `Ctrl-↑` / `Ctrl-↓` | n, i, x | Añadir cursor arriba / abajo |
| `Ctrl-clic` | n, i | Añadir o quitar cursor |
| `<leader>m` | x | Cursores en las líneas de la selección |
| `<leader>a` / `<leader>A` | n, x | Cursores en la palabra / en el área previa |
| `<leader>d` / `<leader>D` | n, x | Añadir y saltar / solo saltar a la siguiente coincidencia |
| `<leader>l` | n, x | Bloquear los cursores virtuales |

### opencode (`<leader>o`)

| Tecla | Modo | Acción |
|---|---|---|
| `<leader>ot` | n | Abrir / cerrar opencode |
| `<leader>oA` | n | Preguntar |
| `<leader>oa` | n, v | Preguntar sobre el cursor / la selección |
| `<leader>on` | n | Nueva sesión |
| `<leader>oy` | n | Copiar la última respuesta |
| `<leader>os` | n, v | Elegir un prompt |
| `<leader>oe` | n | Explicar el código bajo el cursor |
| `Ctrl-Shift-u` / `Ctrl-Shift-d` | n | Subir / bajar media página en los mensajes |

### Windsurf (insert)

| Tecla | Acción |
|---|---|
| `Ctrl-g` | Aceptar sugerencia |
| `Ctrl-;` / `Ctrl-,` | Siguiente / anterior sugerencia |
| `Ctrl-x` | Descartar sugerencia |

### Listas (markdown y `.txt`)

- `Enter` sobre una viñeta vacía termina la lista.
- `>>` / `<<` o `Ctrl-t` / `Ctrl-d` cambian el nivel (`1.` → `a.` → `i.` → `-`).
- `dd` borra la línea y renumera la lista.
- `gN` renumera manualmente.

## Créditos

- [NvChad](https://github.com/NvChad/NvChad) y su [starter](https://github.com/NvChad/starter), que es el punto de partida de este repo (remoto `upstream`).
