# Neovim Configuration

A modern Neovim configuration with Helix-inspired keybindings and workflow, optimized for Elixir, JavaScript/TypeScript, Lua, Rust, Go, and Python development.

## ✨ Features

- 🎯 **Helix-inspired keybindings** - Familiar muscle memory for Helix users
- 🌳 **Treesitter** - Advanced syntax highlighting and code understanding
- 🔍 **LSP Integration** - Full language server support with diagnostics
- 🤖 **AI Pair Programming** - Built-in AI coding assistant (OpenCode)
- 📦 **Mini.nvim Suite** - Lightweight, focused plugins for core functionality
- ⚡ **Fast Startup** - Lazy loading with optimized plugin management
- 🎨 **Beautiful UI** - Zenbones colorscheme with lualine statusline

## 📋 Requirements

- **Neovim** >= 0.11.0
- **Git** >= 2.0
- **Node.js** >= 16.0 (for some LSP servers)
- **ripgrep** (for Telescope grep)
- **fd** (optional, for faster file finding)
- **Language Servers** for your languages (see LSP section)

## 🚀 Installation

1. **Backup existing config** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   # If this is part of your dotfiles
   cd ~/projects/dotfiles
   # Your nvim config should be at dotfiles/nvim
   
   # Create symlink (if needed)
   ln -s ~/projects/dotfiles/nvim ~/.config/nvim
   ```

3. **Install plugins**:
   ```bash
   nvim
   # Lazy.nvim will auto-install on first launch
   # Then run: :Lazy sync
   ```

4. **Install Treesitter parsers**:
   ```vim
   :TSInstall vim vimdoc query lua elixir heex eex erlang javascript typescript python rust go bash html css json yaml markdown markdown_inline
   ```

5. **Install LSP servers** (via Mason or manually):
   ```vim
   :Mason
   ```
   Or install manually for your languages (see LSP Configuration section).

## 📁 Project Structure

```
nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Locked plugin versions
├── filetype.lua            # Custom filetype detection
└── lua/
    └── kody/
        ├── lazy.lua        # Plugin manager setup
        ├── core/
        │   ├── init.lua    # Core module loader
        │   ├── options.lua # Editor options
        │   └── keymaps.lua # Helix-style keybindings (19KB!)
        └── plugins/
            ├── colorscheme.lua
            ├── treesitter.lua
            ├── telescope.lua
            ├── nvim-tree.lua
            ├── oil.lua
            ├── gitsigns.lua
            ├── lualine.lua
            ├── nvim-cmp.lua
            ├── nvim-autopairs.lua
            ├── opencode.lua
            ├── todo-comments.lua
            ├── zellij-nav.lua
            ├── mini-*.lua      # Mini.nvim plugins
            ├── treesitter-textobjects.lua
            └── lsp/
                ├── lspconfig.lua
                └── mason.lua
```

## 🎮 Key Bindings

### Leader Keys
- `<Space>` - Main leader key
- `\\` - Local leader key

### 🧭 Goto Mode (g prefix)

Helix-style navigation with `g` prefix:

| Key | Description |
|-----|-------------|
| `gg` | Go to first line |
| `ge` | Go to last line |
| `gh` | Go to line start |
| `gl` | Go to line end |
| `gs` | Go to first non-blank |
| `gt` | Go to window top |
| `gm` | Go to window middle |
| `gb` | Go to window bottom |
| `ga` | Last accessed file |
| `g.` | Go to last modification |

**LSP Goto:**
| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show references |

### 📂 File Navigation

| Key | Description |
|-----|-------------|
| `<leader>ee` | Toggle file explorer (nvim-tree) |
| `<leader>ef` | Focus file explorer |
| `<leader>ec` | Collapse file explorer |
| `<leader>er` | Refresh file explorer |
| `-` | Open parent directory (Oil) |

### 🔍 Telescope (Fuzzy Finder)

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Grep string |
| `<leader>fc` | Grep cursor word |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>ft` | Todo comments |

### 💬 LSP Actions

| Key | Description |
|-----|-------------|
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>a` | Code actions |
| `<leader>r` | Rename symbol |
| `<leader>d` | Document diagnostics |
| `<leader>D` | Workspace diagnostics |
| `<leader>e` | Line diagnostics |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>rs` | Restart LSP |

### ✂️ Text Objects (Mini.ai + Treesitter)

Treesitter-aware text objects:

| Key | Description |
|-----|-------------|
| `if` / `af` | Inner/around function |
| `ic` / `ac` | Inner/around class |
| `ia` / `aa` | Inner/around parameter |
| `ib` / `ab` | Inner/around block |
| `io` / `ao` | Inner/around conditional/loop |
| `iC` / `aC` | Inner/around comment |

**Examples:**
- `dif` - Delete inner function
- `vaf` - Select around function
- `caa` - Change around parameter

### 🎯 Mini.jump (Extended f/F/t/T)

Character search works across line boundaries (like Helix):
- `f{char}` - Jump to character (forward, across lines)
- `F{char}` - Jump to character (backward, across lines)
- `t{char}` - Jump till character (forward, across lines)
- `T{char}` - Jump till character (backward, across lines)
- `;` - Repeat last jump

### 🔄 Surround Operations (Mini.surround)

| Key | Description |
|-----|-------------|
| `ms{textobj}{char}` | Add surrounding |
| `md{char}` | Delete surrounding |
| `mr{old}{new}` | Replace surrounding |

**Examples:**
- `msiw"` - Surround inner word with quotes
- `msip(` - Surround inner paragraph with parentheses
- `md"` - Delete surrounding quotes
- `mr"'` - Replace double quotes with single quotes

### 🪟 Window Management

| Key | Description |
|-----|-------------|
| `<C-h/j/k/l>` | Navigate windows |
| `<leader>wv` | Vertical split |
| `<leader>ws` | Horizontal split |
| `<leader>wq` | Close window |
| `<leader>wo` | Close others |
| `<leader>w=` | Equalize windows |

### 🔀 Buffer Navigation

| Key | Description |
|-----|-------------|
| `gn` / `]b` | Next buffer |
| `gp` / `[b` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>fb` | Find buffers (Telescope) |

### 📝 Editing

| Key | Description |
|-----|-------------|
| `U` | Redo |
| `J` | Join lines (keep cursor) |
| `<C-d>` / `<C-u>` | Half-page scroll (centered) |
| `n` / `N` | Next/prev match (centered) |
| `x` | Select line |
| `X` | Select to line end |

**Note:** `:w` or `ZZ` to save files (Helix-style)

### 📋 Clipboard

| Key | Description |
|-----|-------------|
| `<leader>y` | Yank to clipboard |
| `<leader>Y` | Yank line to clipboard |
| `<leader>p` | Paste from clipboard |
| `<leader>P` | Paste before from clipboard |

### 🤖 AI Assistant (OpenCode)

| Key | Description |
|-----|-------------|
| `<leader>oo` | Toggle OpenCode terminal |
| `<leader>oa` | Ask with @this context (auto-submit) |
| `<leader>ox` | Select/execute an OpenCode action |
| `<leader>ou` | Scroll OpenCode session up |
| `<leader>od` | Scroll OpenCode session down |
| `go` | Add range to prompt (operator, e.g., `goip`) |
| `goo` | Add current line to prompt |

### 💭 Comments

| Key | Description |
|-----|-------------|
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `gc` + motion | Line comment operator (e.g., `gcap`, `gcip`) |
| `gb` + motion | Block comment operator (e.g., `gbip`, `gb2j`) |
| `gc` (visual) | Line comment selection |
| `gb` (visual) | Block comment selection |
| `gcO` / `gco` / `gcA` | Add comment above/below/at EOL |

### 🎨 UI Toggles

| Key | Description |
|-----|-------------|
| `<leader>uw` | Toggle wrap |
| `<leader>un` | Toggle relative numbers |
| `<leader>us` | Toggle spell check |
| `<leader>ul` | Toggle listchars |

### 📌 Unimpaired Navigation

| Key | Description |
|-----|-------------|
| `]q` / `[q` | Next/prev quickfix |
| `]p` / `[p` | Next/prev paragraph |
| `]<Space>` / `[<Space>` | Add blank line below/above |

## 🔌 Plugin List

### Core Plugins
- **lazy.nvim** - Plugin manager
- **zenbones** - Colorscheme (dark/light)
- **lualine** - Statusline
- **nvim-web-devicons** - File icons

### Navigation & Search
- **telescope.nvim** - Fuzzy finder
- **nvim-tree** - File explorer (width: 40)
- **oil.nvim** - File manager as a buffer

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/tool installer
- **nvim-cmp** - Completion engine
- **cmp-nvim-lsp** - LSP completion source
- **cmp-buffer** - Buffer completion
- **cmp-path** - Path completion
- **LuaSnip** - Snippet engine

### Treesitter
- **nvim-treesitter** - Syntax highlighting
- **nvim-treesitter-textobjects** - Treesitter-aware text objects

### Mini.nvim Suite
- **mini.ai** - Enhanced text objects (Treesitter-aware)
- **mini.surround** - Surround operations (ms/md/mr)
- **mini.jump** - Extended f/F/t/T across lines
- **mini.clue** - Keymap hints (replaces which-key)

### Git Integration
- **gitsigns.nvim** - Git signs in gutter

### editing
- **nvim-autopairs** - Auto-close brackets
- **todo-comments.nvim** - Highlight TODO/FIXME/NOTE

### AI & Productivity
- **opencode.nvim** - AI pair programming assistant powered by OpenCode CLI
- **zellij-nav.nvim** - Seamless Zellij navigation

## 🛠️ LSP Configuration

### Enabled Language Servers

The following LSP servers are configured and can be enabled via Mason:

- **lua_ls** - Lua
- **elixirls** - Elixir/Phoenix
- **ts_ls** - TypeScript/JavaScript
- **html** - HTML
- **cssls** - CSS
- **tailwindcss** - Tailwind CSS
- **gopls** - Go
- **rust_analyzer** - Rust
- **pyright** - Python
- **bashls** - Bash
- **jsonls** - JSON
- **yamlls** - YAML
- **erlangls** - Erlang
- **marksman** - Markdown
- **jdtls** - Java

### Installing Language Servers

**Via Mason (recommended):**
```vim
:Mason
```
Search and install the servers you need.

**Manual Installation:**
```bash
# Elixir
brew install elixir-ls

# TypeScript
npm install -g typescript typescript-language-server

# Lua
brew install lua-language-server

# Others...
```

### LSP Features

- ✅ Auto-completion
- ✅ Go to definition/declaration/references
- ✅ Hover documentation
- ✅ Signature help
- ✅ Code actions (quick fixes)
- ✅ Rename refactoring
- ✅ Diagnostics (errors/warnings)
- ✅ Format on save (configurable)

## 🎨 Colorscheme

**Zenbones** - A collection of calm, low-contrast colorschemes.

Toggle light/dark:
- System theme automatically detected
- Colors work well in kitty/alacritty/wezterm

## 🤖 AI Assistant (OpenCode)

Built-in AI pair programming powered by the OpenCode CLI.

**Setup:**
1. Install the OpenCode CLI: `npm install -g opencode` or `brew install opencode`
2. Connect to GitHub Copilot: Run `/connect` in OpenCode and follow the GitHub auth flow
3. Configure model in `~/.config/opencode/opencode.json`:
   ```json
   {
     "$schema": "https://opencode.ai/config.json",
     "model": "copilot/claude-sonnet-4-5"
   }
   ```

**Usage in Neovim:**
| Key | Description |
|-----|-------------|
| `<leader>oo` | Toggle OpenCode terminal |
| `<leader>oa` | Ask with @this context (auto-submit) |
| `<leader>ox` | Select/execute an OpenCode action |
| `<leader>ou` / `<leader>od` | Scroll OpenCode session |
| `go` | Add range to prompt (operator) |
| `goo` | Add current line to prompt |

## ⚙️ Configuration Tips

### Modify Options

Edit `lua/kody/core/options.lua`:
```lua
opt.relativenumber = true  -- Toggle relative line numbers
opt.tabstop = 2           -- Change tab width
opt.wrap = false          -- Toggle line wrapping
```

### Add New Plugins

Create a new file in `lua/kody/plugins/`:
```lua
-- lua/kody/plugins/my-plugin.lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  opts = {
    -- plugin options
  },
}
```

Lazy.nvim will auto-detect and load it.

### Customize Keybindings

Edit `lua/kody/core/keymaps.lua` - all keybindings are centralized there.

## 🐛 Troubleshooting

### LSP Not Working
1. Check if language server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `<leader>rs`

### Treesitter Highlighting Issues
1. Update parsers: `:TSUpdate`
2. Check installed parsers: `:TSModuleInfo`
3. Manually install: `:TSInstall <language>`

### Plugin Not Loading
1. Check lazy status: `:Lazy`
2. Sync plugins: `:Lazy sync`
3. Check for errors: `:messages`

### Slow Startup
1. Profile startup: `nvim --startuptime startup.log`
2. Review lazy-loading events in plugin configs
3. Consider disabling unused plugins

## 📚 Learning Resources

- **Helix Keymap Reference**: https://docs.helix-editor.com/keymap.html
- **Neovim Lua Guide**: https://neovim.io/doc/user/lua-guide.html
- **Mini.nvim Docs**: https://github.com/echasnovski/mini.nvim

## 🙏 Credits

- Inspired by [Helix editor](https://helix-editor.com/)
- Article: [Making Nvim Act More Like Helix with Mini.nvim](https://evantravers.com/articles/2024/09/17/making-my-nvim-act-more-like-helix-with-mini-nvim/)
- [Mini.nvim](https://github.com/echasnovski/mini.nvim) by @echasnovski
- Community plugins and contributors

---

**Maintained by:** Kody Berry  
**Last Updated:** January 2026  
**Neovim Version:** 0.11.5
