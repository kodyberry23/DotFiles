# Zellij + Neovim Keybindings Reference

## 🔥 Core Concept
The `zellij-autolock` plugin automatically locks Zellij when nvim is running, preventing keybinding conflicts. All keybindings in the `shared_except "locked"` section work **even when nvim is running**.

---

## 📍 Navigation (Works in nvim + Zellij)

| Keybinding | Action |
|------------|--------|
| `Alt+h` / `Alt+←` | Move focus left (nvim split or Zellij pane) |
| `Alt+j` / `Alt+↓` | Move focus down (nvim split or Zellij pane) |
| `Alt+k` / `Alt+↑` | Move focus up (nvim split or Zellij pane) |
| `Alt+l` / `Alt+→` | Move focus right (nvim split or Zellij pane) |

> **Note:** `zellij-nav.nvim` seamlessly integrates nvim splits with Zellij panes!

---

## 🔲 Pane Management (Works even in nvim)

| Keybinding | Action |
|------------|--------|
| `Alt+n` | Create new pane (splits right by default) |
| `Alt+Shift+n` | Create new pane below |
| `Alt+x` | Close current pane |
| `Alt+f` | Toggle pane fullscreen |
| `Alt+z` | Toggle pane frames on/off |

---

## 📑 Tab Management (Works even in nvim)

| Keybinding | Action |
|------------|--------|
| `Alt+t` | Create new tab |
| `Alt+w` | Close current tab |
| `Alt+1-5` | Jump to tab 1-5 |
| `Alt+[` | Go to previous tab |
| `Alt+]` | Go to next tab |

---

## 🔐 Session Management

| Keybinding | Action |
|------------|--------|
| `Ctrl+q` | Detach from session |
| `Alt+q` | Quit Zellij |
| `Ctrl+g` | Manually lock/unlock Zellij |
| `Ctrl+o` → `w` | Open session manager |

---

## 🚀 Quick Workflow Examples

### **Opening a terminal alongside nvim:**
1. In nvim: `Alt+n` → Opens new Zellij pane
2. Navigate between them: `Alt+h/l`

### **Full-screen focus:**
1. `Alt+f` → Maximize current pane
2. `Alt+f` again → Restore layout

### **Multi-project work:**
1. `Alt+t` → New tab for different context
2. `Alt+[` / `Alt+]` → Switch between tabs

---

## 🛠️ Troubleshooting

**Keybindings not working in nvim?**
- Check if Zellij is locked: You should see "LOCKED" in the status bar
- If not locked, press `Ctrl+g` or reload config

**Can't navigate out of nvim?**
- Make sure `zellij-nav.nvim` is loaded (only loads inside Zellij)
- Check `:checkhealth` in nvim

**Want to add more keybindings?**
- Edit `~/.config/zellij/config.kdl`
- Add bindings to the `shared_except "locked"` section
- Reload with `Alt+q` → `zellij attach <session>`

---

## 📚 Related Files

- **Zellij Config:** `~/projects/dotfiles/zellij/config.kdl`
- **Neovim Zellij Plugin:** `~/projects/dotfiles/nvim/lua/kody/plugins/zellij-nav.lua`
- **Session Manager:** Use `zns` alias to create/switch sessions

