# Tmux Configuration

Advanced tmux configuration with custom keybindings, powerful plugins, and a beautiful Rose Pine-themed status bar.

## Features

- **True color support** for modern terminal aesthetics
- **Vim-style keybindings** for navigation and copy mode
- **Popup integrations** for yazi, lazygit, and quick terminals
- **Session management** with sessionx and auto-restore
- **Beautiful status bar** with Rose Pine Main theme
- **Battery & network status** indicators
- **Custom config menu** for quick access to dotfiles

## Theme

Using **Rose Pine Main** with automatic status bar styling:
- Session name with module indicators
- Current directory and username
- Zoom indicator when pane is maximized
- Battery percentage with icon
- Online/offline status indicator
- Transparent background for seamless terminal integration
- Rose Pine's signature soft colors (base, gold, foam, love palette)

## Prefix Key

**`Ctrl+b`** - Default tmux prefix (no secondary prefix)

## Keybindings

### Basic Window Management

| Keybind | Description |
|---------|-------------|
| `prefix` + `r` | Reload tmux config |
| `prefix` + `\|` | Split window horizontally (vertical split) |
| `prefix` + `-` | Split window vertically (horizontal split) |
| `prefix` + `m` | Maximize/zoom current pane |

### Pane Resizing

| Keybind | Description |
|---------|-------------|
| `prefix` + `h` | Resize pane left |
| `prefix` + `j` | Resize pane down |
| `prefix` + `k` | Resize pane up |
| `prefix` + `l` | Resize pane right |

*Note: These are repeatable (`-r`) - hold prefix and tap multiple times*

### Copy Mode (Vim-style)

| Keybind | Description |
|---------|-------------|
| `prefix` + `v` | Enter copy mode |
| `v` (in copy mode) | Begin selection |
| `y` (in copy mode) | Copy selection |

Mouse drag copy is also enabled (without auto-exit).

### Session Management

| Keybind | Description |
|---------|-------------|
| `prefix` + `f` | Tmux sessionizer (custom script) |
| `prefix` + `n` | Create new session (prompts for name) |
| `prefix` + `o` | Open sessionx (fuzzy session switcher) |

### Popup Windows

| Keybind | Description |
|---------|-------------|
| `prefix` + `Ctrl+y` | Yazi file manager (90% size) |
| `prefix` + `Ctrl+t` | Quick terminal (80% size) |
| `prefix` + `Ctrl+g` | Lazygit (90% size) |
| `prefix` + `Ctrl+m` | RMPC music player (95% size) |

### Config Menu

| Keybind | Description |
|---------|-------------|
| `prefix` + `d` | Display config menu |

Opens a menu with quick access to edit:
- `.zshrc` (press `z`)
- `.zprofile` (press `p`)
- `.tmux.conf` (press `t`)
- `.nvim` config (press `v`)
- Quit menu (press `q`)

All open in a popup with nvim.

## Plugins

Managed by [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager)

### Core Plugins

#### [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
Seamless navigation between tmux panes and vim splits using `Ctrl+h/j/k/l`.

#### [sessionx](https://github.com/omerxx/tmux-sessionx)
Fuzzy session switcher with preview. Access with `prefix + o`.

#### [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
Save and restore tmux sessions across system restarts.
- Captures pane contents
- Restores working directories and running programs

#### [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
Auto-save tmux sessions every 15 minutes and auto-restore on tmux start.

### Theme & Status

#### [rose-pine/tmux](https://github.com/rose-pine/tmux)
Beautiful Rose Pine color scheme integration.
- Flavor: Main (options: main, moon, dawn)
- Transparent background support
- Pane borders disabled for clean look

#### [tmux-battery](https://github.com/tmux-plugins/tmux-battery)
Display battery percentage and icon in status bar.
- Shows warning (red) when battery ≤10%

#### [tmux-online-status](https://github.com/tmux-plugins/tmux-online-status)
Display network connection status.
- 󰖩 on - Connected
- 󰖪 off - Disconnected

## Status Bar Layout

```
┌─────────────────────────────────────────────────────────────────┐
│  session │  ~/path │  zoom │ win1 │ win2 │ win3 │  90% │ 󰖩 on │
└─────────────────────────────────────────────────────────────────┘
```

- **Left**: Session name (green, turns red when prefix active) + current path + zoom indicator
- **Center**: Window list with separator pipes
- **Right**: Battery percentage + online status

## Configuration Details

### Colors

Uses Rose Pine Main palette:
- Background: Transparent
- Base colors: Soft muted tones
- Active window: Highlighted with foam/gold
- Inactive windows: Subtle text
- Status indicators: Love (red) for warnings, foam (teal) for info
- Offline: Love (red) text

### Window Settings

- **Base index**: 1 (windows and panes start at 1, not 0)
- **Automatic rename**: Enabled (shows current command)
- **Mouse support**: Enabled for scrolling, resizing, and selecting

### Terminal

- **Default terminal**: `tmux-256color`
- **True color**: Enabled via RGB override
- **Passthrough**: Enabled for terminal features

## Installation

### Prerequisites

```bash
# Install tmux
brew install tmux

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm

# Optional: Install tools for popups
brew install yazi lazygit
```

### Setup

1. **Symlink the config:**
   ```bash
   ln -s ~/projects/dotfiles/tmux ~/.config/tmux
   ```

2. **Source the config:**
   ```bash
   tmux source ~/.config/tmux/tmux.conf
   ```

3. **Install plugins:**
   - Start tmux
   - Press `prefix + I` (capital i) to install plugins
   - Wait for installation to complete

### Custom Scripts

The config references `~/scripts/tmux-sessionizer`. Make sure this script exists or remove the binding.

## Usage Tips

- **Reload config quickly**: `prefix + r`
- **Use sessionx**: `prefix + o` for fuzzy session switching
- **Quick file browsing**: `prefix + Ctrl+y` opens yazi in a popup
- **Git operations**: `prefix + Ctrl+g` opens lazygit in a popup
- **Vim navigation**: Use `Ctrl+h/j/k/l` to move between tmux panes and vim splits seamlessly
- **Sessions persist**: Your sessions auto-save every 15 minutes and restore on tmux restart

## Customization

### Change Theme

Edit the Rose Pine variant:
```bash
set -g @rose_pine_variant "main"  # Options: main, moon, dawn
```

### Adjust Popup Sizes

Modify the `-w` (width) and `-h` (height) percentages in the popup bindings:
```bash
bind-key C-y display-popup -w 90% -h 90% -E "yazi"
```

### Add More Config Menu Items

Extend the display menu in the config:
```bash
bind d display-menu -T "#[align=centre]Config" -x C -y C \
    "New Item"  k  "display-popup -E 'nvim ~/path/to/file'" \
    ...
```

## Troubleshooting

### Colors not working
Ensure your terminal emulator supports true color and TERM is set correctly.

### Plugins not loading
Run `prefix + I` to install, or manually:
```bash
~/.config/tmux/.tmux/plugins/tpm/bin/install_plugins
```

### Sessions not restoring
Check that tmux-resurrect and tmux-continuum are installed and continuum restore is enabled.

## File Structure

```
tmux/
└── tmux.conf          # Main configuration file
```

Plugin data is stored in `~/.config/tmux/.tmux/plugins/`

## Resources

- [Tmux Documentation](https://github.com/tmux/tmux/wiki)
- [TPM - Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [Rose Pine Tmux](https://github.com/rose-pine/tmux)
- [Sessionx](https://github.com/omerxx/tmux-sessionx)
