# Dotfiles

Personal configuration files for my development environment, managed via git for easy synchronization across machines.

## Overview

This repository contains my carefully curated dotfiles for:
- **Neovim** - A heavily customized IDE-like setup with LSP support for multiple languages
- **Ghostty** - A GPU-accelerated terminal emulator with custom keybindings and themes
- **Tmux** - Advanced terminal multiplexer with vim-style navigation and beautiful status bar

## Installation

The configurations are symlinked to `~/.config/` to allow seamless updates when pushing changes to this repository.

### Setup Symlinks

```bash
# Backup existing configs (if any)
mv ~/.config/ghostty ~/.config/ghostty.backup
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.config/tmux ~/.config/tmux.backup

# Create symlinks
ln -s ~/projects/dotfiles/ghostty ~/.config/ghostty
ln -s ~/projects/dotfiles/nvim ~/.config/nvim
ln -s ~/projects/dotfiles/tmux ~/.config/tmux
```

Now any changes made in this repository are immediately reflected in your active configurations.

## Structure

```
dotfiles/
├── ghostty/          # Terminal configuration
│   ├── config        # Main Ghostty config
│   ├── shaders/      # Custom CRT and retro shaders
│   └── themes/       # Color themes (rosepine, tokyonight)
│
├── nvim/             # Neovim configuration
│   ├── init.lua      # Main entry point
│   ├── lua/          # Lua configuration modules
│   │   └── kody/     # Personal config namespace
│   │       ├── core/     # Core settings (options, keymaps)
│   │       └── plugins/  # Plugin configurations
│   └── after/        # Filetype-specific settings
│
└── tmux/             # Tmux configuration
    └── tmux.conf     # Main tmux config with TPM plugins
```

## Quick Links

- [Ghostty Configuration Details](ghostty/README.md)
- [Neovim Configuration Details](nvim/README.md)
- [Tmux Configuration Details](tmux/README.md)

## Philosophy

- **Minimal but powerful**: Only include what you actually use
- **Version controlled**: Track every change, revert when needed
- **Portable**: Easy to set up on new machines
- **Well documented**: Each configuration has detailed explanations

## Requirements

### Ghostty
- Ghostty terminal emulator
- JetBrainsMonoNL Nerd Font

### Neovim
- Neovim >= 0.10.0
- Node.js (for LSP servers)
- Cargo/Rust (for Rust development)
- Python 3 (for Python development)
- Go (for Go development)
- Various language-specific tools (see nvim README)

### Tmux
- Tmux >= 3.0
- TPM (Tmux Plugin Manager)
- Optional: yazi, lazygit for popup integrations

## Contributing

These are personal configurations, but feel free to fork and adapt to your needs!

## License

MIT - Use as you wish
