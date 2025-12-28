# Dotfiles

My personal configuration files for a modern development environment featuring Neovim, Ghostty terminal, Zellij multiplexer, and Oh My Posh prompt.

## 🎯 Philosophy

This configuration prioritizes:

- ⚡ **Performance** - Fast startup times and responsive tools
- 🎨 **Aesthetics** - Beautiful, consistent theming across all tools
- 🎮 **Helix-inspired** - Familiar keybindings from Helix editor
- 🛠️ **Developer Experience** - Optimized for Elixir, TypeScript, Rust, Go, and Python


## 📦 What's Included

### 🔧 Core Tools

| Tool | Description | Config Location |
| :-- | :-- | :-- |
| **Neovim** | Modal text editor with Helix-style keybindings | [`nvim/`](./nvim) |
| **Ghostty** | Fast, native terminal emulator | [`ghostty/`](./ghostty) |
| **Zellij** | Terminal multiplexer (tmux alternative) | [`zellij/`](./zellij) |
| **Oh My Posh** | Cross-platform prompt theme engine | [`oh-my-posh/`](./oh-my-posh) |

### ✨ Key Features

#### Neovim

- 🎯 Helix-inspired keybindings (extensive 19KB keymap file!)
- 🌳 Treesitter syntax highlighting
- 🔍 Full LSP support (12+ language servers)
- 🤖 AI pair programming (CodeCompanion)
- 📦 Mini.nvim suite for lightweight plugins
- 🎨 Zenbones colorscheme
- See full details: [`nvim/README.md`](./nvim/README.md)


#### Ghostty

- GPU-accelerated rendering
- Native macOS performance
- Custom theming
- Font ligature support


#### Zellij

- Modern tmux alternative
- Seamless nvim integration
- Custom layouts
- Mouse support


#### Oh My Posh

- Customized prompt
- Git status integration
- Fast and lightweight


## 🚀 Quick Start

### Prerequisites

```bash
# Install Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# Install core tools
brew install neovim zellij oh-my-posh fzf zoxide treesitter treesitter-cli fd ripgrep
brew install --cask ghostty
```


### Installation

1. **Clone this repository:**

```bash
git clone [https://github.com/YOUR_USERNAME/dotfiles.git](https://github.com/YOUR_USERNAME/dotfiles.git) ~/projects/dotfiles
cd ~/projects/dotfiles
```

2. **Create symlinks:**

```bash
# Neovim
ln -s ~/projects/dotfiles/nvim ~/.config/nvim

# Ghostty
ln -s ~/projects/dotfiles/ghostty ~/.config/ghostty

# Zellij
ln -s ~/projects/dotfiles/zellij ~/.config/zellij

# Oh My Posh
ln -s ~/projects/dotfiles/oh-my-posh ~/.config/oh-my-posh
```

3. **Install Neovim plugins:**

```bash
nvim
# Lazy.nvim will auto-install plugins
# Then: :Lazy sync
# Then: :TSInstall all
```

4. **Verify setup:**

```bash
nvim --version  # Should be 0.11+
zellij --version
oh-my-posh --version
```


## 📁 Repository Structure

```
dotfiles/
├── README.md              # This file
├── KEYMAPS.md            # Complete keymap reference (23KB!)
├── nvim/                 # Neovim configuration
│   ├── README.md         # Detailed nvim docs
│   ├── init.lua
│   └── lua/kody/
│       ├── core/
│       │   ├── options.lua
│       │   └── keymaps.lua
│       └── plugins/      # 17+ plugin configs
├── ghostty/              # Terminal emulator
│   └── config
├── zellij/               # Terminal multiplexer
│   ├── config.kdl
│   └── layouts/
└── oh-my-posh/           # Shell prompt
    └── theme.json
```


## 🎮 Keybindings Overview

All keybindings are centralized in Neovim's [`nvim/lua/kody/core/keymaps.lua`](./nvim/lua/kody/core/keymaps.lua).

### Quick Reference

| Prefix | Mode | Purpose |
| :-- | :-- | :-- |
| `<Space>` | Leader | Main commands (files, LSP, toggles) |
| `g` | Goto | Navigation (lines, definitions, references) |
| `]` / `[` | Next/Prev | Diagnostics, buffers, hunks, paragraphs |
| `m` | Match | Surround operations, brackets |
| `z` | View | Scrolling, folding, centering |

**Detailed keybindings:** See [`KEYMAPS.md`](./KEYMAPS.md) or [`nvim/README.md`](./nvim/README.md)

## 🛠️ Customization

### Neovim

Modify configurations in `nvim/lua/kody/`:

- **Options:** `core/options.lua`
- **Keymaps:** `core/keymaps.lua`
- **Plugins:** Add files to `plugins/`


### Ghostty

Edit `ghostty/config`:

```conf
theme = dark:zenbones_dark,light:zenbones_light
font-family = JetBrainsMono Nerd Font
font-size = 14
```


### Zellij

Edit `zellij/config.kdl`:

```kdl
theme "zenbones"
default_layout "compact"
```


### Oh My Posh

Edit `oh-my-posh/theme.json` to customize prompt segments.

## 🔧 Development Setup

### Language-Specific Tools

**Elixir/Phoenix:**

```bash
brew install elixir elixir-ls
# LSP: elixirls (via Mason or brew)
```

**JavaScript/TypeScript:**

```bash
npm install -g typescript typescript-language-server
# LSP: ts_ls
```

**Rust:**

```bash
brew install rust rust-analyzer
# LSP: rust_analyzer
```

**Go:**

```bash
brew install go gopls
# LSP: gopls
```

**Python:**

```bash
brew install python
pip install pyright
# LSP: pyright
```


### LSP Servers

Install via Neovim's Mason:

```vim
:Mason
```

Or see full list in [`nvim/README.md`](./nvim/README.md#-lsp-configuration)

## 🐛 Troubleshooting

### Neovim Issues

**Plugins not loading:**

```vim
:Lazy sync
:Lazy restore
```

**LSP not working:**

```vim
:LspInfo
:Mason
<leader>rs  " Restart LSP
```

**Treesitter errors:**

```vim
:TSUpdate
:TSInstall <language>
```


### Symlink Issues

**Broken symlinks:**

```bash
# Remove old symlinks
rm ~/.config/nvim ~/.config/ghostty ~/.config/zellij ~/.config/oh-my-posh


# Recreate
ln -s ~/projects/dotfiles/nvim ~/.config/nvim
ln -s ~/projects/dotfiles/ghostty ~/.config/ghostty
ln -s ~/projects/dotfiles/zellij ~/.config/zellij
ln -s ~/projects/dotfiles/oh-my-posh ~/.config/oh-my-posh
```


### Terminal Issues

**Colors not showing:**

1. Check `TERM` environment variable
2. Enable true color in terminal settings
3. Verify terminal supports 24-bit color

## 📚 Documentation

- **Neovim:** [`nvim/README.md`](./nvim/README.md) - Comprehensive Neovim guide
- **Keymaps:** [`KEYMAPS.md`](./KEYMAPS.md) - Complete keymap reference
- **Scripts:** [`scripts/`](./scripts) - Utility scripts (if any)


## 🙏 Credits \& Inspiration

- **Helix Editor** - Keymap philosophy and design
- **Mini.nvim** - Lightweight, focused plugins by @echasnovski
- **Article:** [Making Nvim Act More Like Helix with Mini.nvim](https://evantravers.com/articles/2024/09/17/making-my-nvim-act-more-like-helix-with-mini-nvim/)
- **Zenbones** - Colorscheme by @mcchrish
- **Ghostty** - Terminal by @mitchellh
- **Zellij** - Multiplexer by Zellij contributors


## 📝 Notes

### Neovim Version

Requires Neovim 0.11+ for latest LSP and Treesitter APIs.

### Terminal Compatibility

Tested with:

- ✅ Ghostty
- ✅ Kitty
- ✅ Alacritty
- ✅ iTerm2
- ✅ WezTerm


### OS Support

Primary: **macOS**
May work on Linux with minor adjustments.

## 🔄 Updates

To update all tools:

```bash
# Homebrew packages
brew update && brew upgrade


# Neovim plugins
nvim -c "Lazy sync" -c "TSUpdate"


# Pull latest dotfiles
cd ~/projects/dotfiles
git pull
```


---

**Maintained by:** Kody Berry
**Last Updated:** December 2024
**Neovim Version:** 0.11.5

**License:** MIT (or your preferred license)

Here's your updated README.md:

```markdown
# Dotfiles

My personal configuration files for a modern development environment featuring Neovim, Ghostty terminal, Zellij multiplexer, and Oh My Posh prompt.

## 🎯 Philosophy

This configuration prioritizes:
- ⚡ **Performance** - Fast startup times and responsive tools
- 🎨 **Aesthetics** - Beautiful, consistent theming across all tools
- 🎮 **Helix-inspired** - Familiar keybindings from Helix editor
- 🛠️ **Developer Experience** - Optimized for Elixir, TypeScript, Rust, Go, and Python

## 📦 What's Included

### 🔧 Core Tools

| Tool | Description | Config Location |
|------|-------------|-----------------|
| **Neovim** | Modal text editor with Helix-style keybindings | [`nvim/`](./nvim) |
| **Ghostty** | Fast, native terminal emulator | [`ghostty/`](./ghostty) |
| **Zellij** | Terminal multiplexer (tmux alternative) | [`zellij/`](./zellij) |
| **Oh My Posh** | Cross-platform prompt theme engine | [`oh-my-posh/`](./oh-my-posh) |

### ✨ Key Features

#### Neovim
- 🎯 Helix-inspired keybindings (extensive keymap configuration)
- 🌳 Treesitter syntax highlighting
- 🔍 Full LSP support (12+ language servers)
- 💬 Auto-completion with nvim-cmp + autopairs integration
- 🤖 AI pair programming (CodeCompanion)
- 📦 Mini.nvim suite for lightweight plugins
- 🎨 Zenbones colorscheme
- ✨ Multi-cursor support (vim-visual-multi) with Helix-style selection manipulation
- See full details: [`nvim/README.md`](./nvim/README.md)

#### Ghostty
- GPU-accelerated rendering
- Native macOS performance
- Custom theming (Rosé Pine, Tokyo Night)
- CRT shader effects
- Font ligature support

#### Zellij
- Modern tmux alternative
- Seamless nvim integration
- Custom layouts
- Mouse support

#### Oh My Posh
- Customized prompt themes (Rosé Pine, Tokyo Night)
- Git status integration
- Fast and lightweight

## 🚀 Quick Start

### Prerequisites

```


# Install Homebrew (macOS)

/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools

brew install neovim zellij oh-my-posh fzf zoxide fd ripgrep bat eza
brew install --cask ghostty

```

### Installation

1. **Clone this repository:**
```

git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles

```

2. **Create symlinks:**
```


# Neovim

ln -s ~/projects/dotfiles/nvim ~/.config/nvim

# Ghostty

ln -s ~/projects/dotfiles/ghostty ~/.config/ghostty

# Zellij

ln -s ~/projects/dotfiles/zellij ~/.config/zellij

# Oh My Posh

ln -s ~/projects/dotfiles/oh-my-posh ~/.config/oh-my-posh

```

3. **Install Neovim plugins:**
```

nvim

# Lazy.nvim will auto-install plugins

# Then: :Lazy sync

# Then: :TSUpdate

```

4. **Verify setup:**
```

nvim --version  \# Should be 0.11+
zellij --version
oh-my-posh --version

```

## 📁 Repository Structure

```

dotfiles/
├── README.md              \# This file
├── KEYMAPS.md            \# Complete keymap reference
├── nvim/                 \# Neovim configuration
│   ├── README.md         \# Detailed nvim docs
│   ├── init.lua          \# Entry point (disables matchit)
│   ├── filetype.lua      \# Filetype detection
│   └── lua/kody/
│       ├── core/
│       │   ├── init.lua
│       │   ├── options.lua
│       │   └── keymaps.lua
│       ├── lazy.lua      \# Plugin manager
│       └── plugins/      \# 20+ plugin configs
├── ghostty/              \# Terminal emulator
│   ├── config
│   ├── shaders/          \# CRT effects
│   └── themes/
├── zellij/               \# Terminal multiplexer
│   ├── config.kdl
│   └── layouts/
├── oh-my-posh/           \# Shell prompt
│   ├── rosepine.omp.json
│   └── tokyonight-storm.omp.json
└── scripts/
└── sessionizer.sh    \# Project switcher

```

## 🎮 Keybindings Overview

All keybindings are centralized in Neovim's [`nvim/lua/kody/core/keymaps.lua`](./nvim/lua/kody/core/keymaps.lua).

### Quick Reference

| Key | Purpose | Description |
|-----|---------|-------------|
| `%` | Select all | Select entire buffer (Helix style) |
| `<Space>` | Leader | Main commands (files, LSP, toggles) |
| `g` | Goto | Navigation (lines, definitions, references) |
| `]` / `[` | Next/Prev | Diagnostics, buffers, hunks, paragraphs |
| `m` | Match | Surround operations, brackets, text objects |
| `z` | View | Scrolling, folding, centering |
| `<C-n>` | Multi-cursor | Start vim-visual-multi (Helix-style) |

### Helix-Style Features

- **`%`** - Select entire buffer (matchit disabled to enable this)
- **`x`** - Select line / extend selection
- **`d` / `c`** - Delete/change without yanking (in visual mode)
- **`mm`** - Match brackets (replaces Vim's `%`)
- **`mi` / `ma`** - Inner/around text objects
- **`ms` / `mr` / `md`** - Surround add/replace/delete
- **Multi-cursor** - Start with `<C-n>`, then use Helix keys (`s`, `S`, `&`, `_`, etc.)

**Detailed keybindings:** See [`KEYMAPS.md`](./KEYMAPS.md) or [`nvim/README.md`](./nvim/README.md)

## 🛠️ Customization

### Neovim

Modify configurations in `nvim/lua/kody/`:
- **Options:** `core/options.lua`
- **Keymaps:** `core/keymaps.lua`
- **Plugins:** Add files to `plugins/`

#### Important: Matchit Plugin

The matchit plugin is **disabled** in `init.lua` to allow `%` to be used for select-all (Helix style):

```

-- In nvim/init.lua (before loading plugins)
vim.g.loaded_matchit = 1

```

The original bracket-matching functionality is preserved via `mm` in Match Mode.

### Ghostty

Edit `ghostty/config`:
```

theme = dark:tokyonight-storm,light:rosepine-dawn
font-family = JetBrainsMono Nerd Font
font-size = 14

```

### Zellij

Edit `zellij/config.kdl`:
```

theme "tokyo-night-storm"
default_layout "compact"

```

### Oh My Posh

Edit theme files in `oh-my-posh/`:
- `rosepine.omp.json`
- `tokyonight-storm.omp.json`

## 🔧 Development Setup

### Language-Specific Tools

**Elixir/Phoenix:**
```

brew install elixir

# LSP: elixir-ls (via Mason)

```

**JavaScript/TypeScript:**
```

npm install -g typescript typescript-language-server

# LSP: ts_ls (via Mason)

```

**Rust:**
```

brew install rust rust-analyzer

# LSP: rust_analyzer (via Mason)

```

**Go:**
```

brew install go gopls

# LSP: gopls (via Mason)

```

**Python:**
```

brew install python

# LSP: pyright (via Mason)

```

### LSP Servers

Install via Neovim's Mason:
```

:Mason

```

Or see full list in [`nvim/README.md`](./nvim/README.md#-lsp-configuration)

## 🐛 Troubleshooting

### Neovim Issues

**Plugins not loading:**
```

:Lazy sync
:Lazy restore

```

**LSP not working:**
```

:LspInfo
:Mason
<leader>rs  " Restart LSP

```

**Treesitter errors:**
```

:TSUpdate
:TSInstall <language>

```

**`%` select-all not working:**
1. Check that `vim.g.loaded_matchit = 1` is in `init.lua` before plugins load
2. Restart Neovim completely
3. Clear cache: `rm -rf ~/.cache/nvim ~/.local/state/nvim`
4. Verify with `:map %` (should show your custom mapping)

**Completion not working:**
```

:checkhealth nvim-cmp

```

Make sure `windwp/nvim-autopairs` is in your cmp dependencies.

### Symlink Issues

**Broken symlinks:**
```


# Remove old symlinks

rm ~/.config/nvim ~/.config/ghostty ~/.config/zellij ~/.config/oh-my-posh

# Recreate

ln -s ~/projects/dotfiles/nvim ~/.config/nvim
ln -s ~/projects/dotfiles/ghostty ~/.config/ghostty
ln -s ~/projects/dotfiles/zellij ~/.config/zellij
ln -s ~/projects/dotfiles/oh-my-posh ~/.config/oh-my-posh

```

### Terminal Issues

**Colors not showing:**
1. Check `TERM` environment variable (should be `xterm-256color` or `xterm-ghostty`)
2. Enable true color in terminal settings
3. Verify terminal supports 24-bit color: `echo $COLORTERM` (should output `truecolor`)

**Zellij navigation conflicts:**
- `<C-p>` removed from nvim-cmp to avoid Zellij pane mode conflicts
- Use `<S-Tab>` or arrow keys for previous completion item

## 📚 Documentation

- **Neovim:** [`nvim/README.md`](./nvim/README.md) - Comprehensive Neovim guide
- **Keymaps:** [`KEYMAPS.md`](./KEYMAPS.md) - Complete keymap reference (23KB+)
- **Scripts:** [`scripts/`](./scripts) - Utility scripts

## 🙏 Credits & Inspiration

- **Helix Editor** - Keymap philosophy and design
- **Mini.nvim** - Lightweight, focused plugins by @echasnovski
- **vim-visual-multi** - Multi-cursor support by @mg979
- **Article:** [Making Nvim Act More Like Helix with Mini.nvim](https://evantravers.com/articles/2024/09/17/making-my-nvim-act-more-like-helix-with-mini-nvim/)
- **Rosé Pine** - Colorscheme by @rose-pine
- **Tokyo Night** - Colorscheme by @folke
- **Ghostty** - Terminal by @mitchellh
- **Zellij** - Multiplexer by Zellij contributors

## 📝 Notes

### Neovim Version
Requires Neovim 0.11+ for latest LSP and Treesitter APIs.

### Terminal Compatibility
Tested with:
- ✅ Ghostty (primary)
- ✅ Kitty
- ✅ Alacritty
- ✅ iTerm2
- ✅ WezTerm

### OS Support
Primary: **macOS**  
May work on Linux with minor adjustments.

### Keyboard Shortcuts
Some terminal shortcuts may not work (e.g., `<S-CR>`, `<C-CR>`) depending on your terminal emulator's key code support.

## 🔄 Updates

To update all tools:
```


# Homebrew packages

brew update \&\& brew upgrade

# Neovim plugins

nvim -c "Lazy sync" -c "TSUpdate"

# Pull latest dotfiles

cd ~/projects/dotfiles
git pull

```

## 📅 Recent Changes

**2025-12-28:**
- Fixed `%` select-all by disabling matchit plugin
- Simplified keymap implementations (removed feedkeys complexity)
- Updated nvim-cmp with autopairs integration
- Removed `<C-p>` from cmp to avoid Zellij conflicts
- Enhanced autopairs configuration with safety checks
- Improved case transformation mappings

---

**Maintained by:** Kody Berry  
**Last Updated:** December 28, 2025  
**Neovim Version:** 0.11+

**License:** MIT
```

