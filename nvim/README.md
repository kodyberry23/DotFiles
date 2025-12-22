# Neovim Configuration

A comprehensive Neovim configuration optimized for full-stack development with extensive LSP support, modern UI enhancements, and powerful navigation tools.

## Features

- 🚀 **20+ Language Servers** configured and ready to use
- 🎨 **Multiple colorschemes** with live preview and persistence
- 📦 **Lazy.nvim** plugin manager for fast startup times
- 🔍 **Telescope** fuzzy finder for files, grep, and more
- 🎯 **Harpoon** for quick file navigation
- 💡 **Auto-completion** with nvim-cmp and LuaSnip
- 🐛 **DAP debugging** support (Go and more)
- ✨ **Treesitter** syntax highlighting
- 🔧 **Conform.nvim** for formatting
- 🔎 **nvim-lint** for linting
- 📁 **Oil.nvim** as default file explorer (vim-style directory editing)

## Leader Key

**Space** (` `) is the leader key for most custom keybindings.

---

## Plugins

### Core Functionality

#### [lazy.nvim](https://github.com/folke/lazy.nvim)
Modern plugin manager with automatic lazy-loading for optimal startup performance.

#### [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
Lua utility functions used by many plugins.

### Navigation & File Management

#### [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
Fuzzy finder for files, live grep, buffers, and more.
- **Keybinds:**
  - `<leader>pr` - Recent files
  - `<leader>pWs` - Find word under cursor
  - `<leader>ths` - Theme switcher

#### [harpoon](https://github.com/ThePrimeagen/harpoon) (v2)
Quick file navigation - mark important files and jump between them instantly.
- **Keybinds:**
  - `<leader>a` - Add file to harpoon
  - `<C-e>` - Toggle harpoon menu
  - `<C-y>`, `<C-u>`, `<C-i>`, `<C-o>` - Jump to marked files 1-4

#### [oil.nvim](https://github.com/stevearc/oil.nvim)
Edit your filesystem like a buffer - default file explorer.
- **Keybinds:**
  - `-` - Open parent directory
  - `<leader>-` - Open in floating window
  - `q` - Close oil buffer
- **Features:** Trash support, hidden files shown, no confirmations for simple edits

#### [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
Traditional file tree explorer (currently disabled in favor of Oil).

### LSP & Language Support

#### [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
Quickstart configurations for Neovim's built-in LSP client.

**Configured Language Servers:**
- **Lua**: `lua_ls` - Lua language server with Neovim API support
- **TypeScript/JavaScript**: `ts_ls` - Full TS/JS support with module completions
- **Go**: `gopls` - Go language server with gofumpt formatting
- **Python**: `pyright` - Type checking and IntelliSense for Python
- **Rust**: `rust_analyzer` - Rust language server with clippy integration
- **Elixir**: `elixirls` - Elixir language server with dialyzer
- **C/C++**: `clangd` - Clang-based language server
- **Java**: `jdtls` - Eclipse JDT language server
- **HTML**: `html` - HTML language server
- **CSS**: `cssls` - CSS language server
- **JSON**: `jsonls` - JSON language server with schema validation
- **YAML**: `yamlls` - YAML with schema support (GitHub workflows, docker-compose)
- **Tailwind CSS**: `tailwindcss` - IntelliSense for Tailwind classes
- **Emmet**: `emmet_ls`, `emmet_language_server` - HTML/CSS abbreviation expansion
- **Astro**: `astro` - Astro framework support

**LSP Keybinds (active when LSP attached):**
- `gR` - Show LSP references (Telescope)
- `gD` - Go to declaration
- `gd` - Show LSP definitions (Telescope)
- `gi` - Show LSP implementations (Telescope)
- `gt` - Show LSP type definitions (Telescope)
- `<leader>vca` - Show code actions
- `<leader>rn` - Smart rename
- `<leader>D` - Show buffer diagnostics
- `<leader>d` - Show line diagnostics
- `K` - Show documentation hover
- `<C-h>` (insert mode) - Signature help
- `<leader>rs` - Restart LSP
- `<leader>lx` - Toggle LSP diagnostics visibility

#### [mason.nvim](https://github.com/williamboman/mason.nvim)
Package manager for LSP servers, DAP servers, linters, and formatters.

### Autocompletion

#### [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
Completion engine with multiple sources.
- **Sources:** LSP, buffer, path, LuaSnip, spell checking
- **Enhanced with:** lspkind for VS Code-style icons, Tailwind color previews

#### [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
Snippet engine with friendly-snippets integration.

### Treesitter

#### [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
Syntax highlighting and code understanding using Tree-sitter.
- **Parsers installed:** JavaScript, TypeScript, TSX, Go, Python, Rust, Lua, Markdown, HTML, CSS, JSON, YAML, Bash, C, Java, Docker, and more

#### [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
Auto-close and auto-rename HTML/JSX tags.

### Formatting & Linting

#### [conform.nvim](https://github.com/stevearc/conform.nvim)
Async formatter with multiple formatter support.
- **Keybind:** `<leader>f` - Format current buffer
- **Formatters:**
  - JS/TS/React: `biome-check`
  - Svelte: `prettier`
  - JSON/YAML/GraphQL: `prettier`
  - Lua: `stylua`
  - Markdown: `prettier` + `markdown-toc`

#### [nvim-lint](https://github.com/mfussenegger/nvim-lint)
Async linter with multiple linter support.
- **Keybind:** `<leader>l` - Trigger linting
- **Linters:**
  - JS/TS/React: `biomejs`
  - Python: `pylint`

### Debugging

#### [nvim-dap](https://github.com/mfussenegger/nvim-dap)
Debug Adapter Protocol client for debugging.
- **Keybinds:**
  - `<leader>db` - Toggle breakpoint
  - `<leader>dc` - Continue/start debugging

#### [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
UI for nvim-dap with variable inspection, stack traces, and more.

#### [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
Go debugging support via Delve.

### Git Integration

#### [gitstuff.lua](lua/kody/plugins/gitstuff.lua)
Git integration plugins (likely gitsigns.nvim or similar).

#### [gitworktree.lua](lua/kody/plugins/gitworktree.lua)
Manage git worktrees from within Neovim.

### UI & Visual Enhancements

#### [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
Fast and customizable statusline with lazy.nvim update counter.

#### [noice.nvim](https://github.com/folke/noice.nvim)
Better UI for messages, cmdline, and popups.

#### [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
Live markdown rendering in Neovim.

#### [snacks.nvim](https://github.com/folke/snacks.nvim)
Collection of small QoL improvements and UI enhancements.

#### [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
Ultra fold - better folding with Treesitter and LSP support.

#### [colorscheme.lua](lua/kody/plugins/colorscheme.lua)
Multiple colorscheme configurations:
- **Rose Pine** (main, moon, dawn variants)
- **Gruvbox**
- **Tokyo Night**
- **Catppuccin**
- **OneDark**
- And more...

Use `<leader>ths` to switch themes with live preview.

### Utilities

#### [auto-session.nvim](https://github.com/rmagatti/auto-session)
Automatic session management.
- **Keybinds:**
  - `<leader>wr` - Restore session
  - `<leader>ws` - Save session

#### [undotree](https://github.com/mbbill/undotree)
Visualize undo history as a tree.

#### [vim-maximizer](https://github.com/szw/vim-maximizer)
Maximize and restore current window.

#### [trouble.nvim](https://github.com/folke/trouble.nvim)
Pretty list for diagnostics, references, quickfix, and location lists.

#### [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
Highlight and search for TODO, FIXME, NOTE, etc. comments.

#### [mini.nvim](https://github.com/echasnovski/mini.nvim)
Collection of minimal, independent Lua modules.

#### [surround.nvim](https://github.com/kylechui/nvim-surround)
Add, change, and delete surrounding characters/tags.

#### [auto-pairs.lua](lua/kody/plugins/auto-pairs.lua)
Automatically insert closing brackets, quotes, etc.

#### [emmet.lua](lua/kody/plugins/emmet.lua)
Emmet abbreviation expansion.

#### [tailwind-tools.lua](lua/kody/plugins/tailwind-tools.lua)
Enhanced Tailwind CSS support with color previews and class sorting.

#### [showkeys.nvim](https://github.com/nvzone/showkeys)
Show keypresses on screen (useful for demos/screencasts).

#### [image-support.lua](lua/kody/plugins/image-support.lua)
Display images in Neovim (likely image.nvim or similar).

---

## Keybindings Cheatsheet

### General

| Keybind | Mode | Description |
|---------|------|-------------|
| `<Space>` | Normal | Leader key |
| `<leader><leader>` | Normal | Source/reload config |
| `<C-c>` | Insert | Escape |
| `<C-c>` | Normal | Clear search highlights |
| `<leader>f` | Normal | Format buffer with LSP |
| `Q` | Normal | Disabled (was Ex mode) |

### Navigation

| Keybind | Mode | Description |
|---------|------|-------------|
| `<C-d>` | Normal | Move down half page (centered) |
| `<C-u>` | Normal | Move up half page (centered) |
| `n` | Normal | Next search result (centered) |
| `N` | Normal | Previous search result (centered) |

### Editing

| Keybind | Mode | Description |
|---------|------|-------------|
| `J` | Visual | Move lines down |
| `K` | Visual | Move lines up |
| `J` | Normal | Join lines (preserve cursor) |
| `<` | Visual | Decrease indent (reselect) |
| `>` | Visual | Increase indent (reselect) |
| `<leader>p` | Visual | Paste without yanking |
| `p` | Visual | Paste without yanking replaced text |
| `<leader>Y` | Normal | Yank to system clipboard |
| `<leader>d` | Normal/Visual | Delete without yanking |
| `x` | Normal | Delete char without yanking |
| `<leader>s` | Normal | Global replace word under cursor |
| `<leader>x` | Normal | Make file executable |

### File Management

| Keybind | Mode | Description |
|---------|------|-------------|
| `-` | Normal | Open parent dir (Oil.nvim) |
| `<leader>-` | Normal | Open parent dir (float) |
| `<leader>fp` | Normal | Copy file path to clipboard |

### Telescope

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>pr` | Normal | Recent files |
| `<leader>pWs` | Normal | Find word under cursor |
| `<leader>ths` | Normal | Theme switcher |

### Harpoon

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>a` | Normal | Add file to harpoon |
| `<C-e>` | Normal | Toggle harpoon menu |
| `<C-y>` | Normal | Jump to harpoon file 1 |
| `<C-u>` | Normal | Jump to harpoon file 2 |
| `<C-i>` | Normal | Jump to harpoon file 3 |
| `<C-o>` | Normal | Jump to harpoon file 4 |

### LSP

| Keybind | Mode | Description |
|---------|------|-------------|
| `gR` | Normal | Show references (Telescope) |
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Show definitions (Telescope) |
| `gi` | Normal | Show implementations |
| `gt` | Normal | Show type definitions |
| `K` | Normal | Hover documentation |
| `<C-h>` | Insert | Signature help |
| `<leader>vca` | Normal/Visual | Code actions |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>D` | Normal | Buffer diagnostics |
| `<leader>d` | Normal | Line diagnostics |
| `<leader>rs` | Normal | Restart LSP |
| `<leader>lx` | Normal | Toggle diagnostics |

### Debugging

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dc` | Normal | Continue debugging |

### Tabs

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>to` | Normal | New tab |
| `<leader>tx` | Normal | Close tab |
| `<leader>tn` | Normal | Next tab |
| `<leader>tp` | Normal | Previous tab |
| `<leader>tf` | Normal | Open current file in new tab |

### Splits

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>sv` | Normal | Split vertically |
| `<leader>sh` | Normal | Split horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |

### Sessions

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>wr` | Normal | Restore session |
| `<leader>ws` | Normal | Save session |

### Linting

| Keybind | Mode | Description |
|---------|------|-------------|
| `<leader>l` | Normal | Trigger linting |

### Tmux Integration

| Keybind | Mode | Description |
|---------|------|-------------|
| `<C-f>` | Normal | New tmux session |

---

## File Structure

```
nvim/
├── init.lua                    # Entry point, loads core config
├── lazy-lock.json             # Plugin version lockfile
│
├── lua/
│   ├── current-theme.lua      # Theme persistence
│   └── kody/
│       ├── lazy.lua           # Lazy.nvim setup
│       ├── terminalpop.lua    # Terminal popup config
│       │
│       ├── core/
│       │   ├── init.lua       # Core initialization
│       │   ├── keymaps.lua    # Global keybindings
│       │   └── options.lua    # Neovim options
│       │
│       └── plugins/
│           ├── init.lua       # Plugin initialization
│           ├── [plugin-name].lua   # Individual plugin configs
│           │
│           └── lsp/
│               ├── mason.lua      # Mason LSP installer
│               └── lspconfig.lua  # LSP configurations
│
└── after/
    └── ftplugin/
        ├── markdown.lua       # Markdown-specific settings
        ├── python.lua         # Python-specific settings
        └── typescriptreact.lua # React/TSX-specific settings
```

## Installation

1. **Prerequisites:**
   ```bash
   # Install Neovim (>= 0.10.0)
   brew install neovim
   
   # Install language tools
   brew install node python go rust
   ```

2. **Clone and symlink:**
   ```bash
   # Backup existing config
   mv ~/.config/nvim ~/.config/nvim.backup
   
   # Symlink this config
   ln -s ~/projects/dotfiles/nvim ~/.config/nvim
   ```

3. **Open Neovim:**
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first launch.

4. **Install LSP servers:**
   Open Neovim and run `:Mason` to see installed/available LSP servers.
   Most are configured to auto-install, but you can manually install with `:MasonInstall <server-name>`.

## Customization

- **Change theme:** `<leader>ths` or edit [current-theme.lua](lua/current-theme.lua)
- **Add plugins:** Create new file in `lua/kody/plugins/`
- **Modify keybinds:** Edit [keymaps.lua](lua/kody/core/keymaps.lua)
- **Adjust options:** Edit [options.lua](lua/kody/core/options.lua)

## Tips

- Use `:Lazy` to manage plugins (update, clean, profile)
- Use `:Mason` to manage LSP servers and tools
- Use `:checkhealth` to diagnose configuration issues
- Use `K` on a word to see its documentation (when LSP is active)
- Use `gd` to jump to definition (Telescope picker)
- Press `<leader>ths` to try different themes with live preview

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Config Guide](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
