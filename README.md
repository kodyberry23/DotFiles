# Dotfiles

Personal configuration for a modern macOS development environment: **Neovim** with Helix-style keybindings, **Ghostty** terminal, **Zellij** multiplexer, **Oh My Posh** prompt, and **mise** for per-project runtime versioning.

## Philosophy

- **Helix-inspired** — Neovim keymaps mirror Helix's selection-first model (`x` selects line, `gh/gl` line start/end, `mm` matching bracket, `s/S` multi-cursor, etc.)
- **Per-project everything** — mise manages Node/Python/Elixir versions per project so projects don't fight over global runtimes
- **Fast** — lazy-loaded plugins, snacks.nvim for UI, carefully tuned LSPs (rust-analyzer and vtsls both have memory-pruning settings)
- **Cyberdream** — consistent theme across nvim, zellij, oh-my-posh, and fzf

## What's in this repo

| Directory | Purpose |
|-----------|---------|
| [`nvim/`](./nvim) | Neovim config — 20+ plugins, native LSP via `vim.lsp.config` (requires 0.11+) |
| [`ghostty/`](./ghostty) | Ghostty terminal config (cyberdream theme, custom shaders) |
| [`zellij/`](./zellij) | Zellij multiplexer config + layouts |
| [`oh-my-posh/`](./oh-my-posh) | Prompt themes (cyberdream is active) |
| [`zsh-helix-mode/`](./zsh-helix-mode) | zsh line editor with Helix keybindings |
| [`helix/`](./helix) | Helix editor config (for occasional use) |
| [`scripts/`](./scripts) | `setup.sh`, `install-elixir-ls.sh`, `sessionizer.sh` |
| [`KEYMAPS.md`](./KEYMAPS.md) | Full keymap reference |

## Quick start

```bash
git clone https://github.com/kodyberry/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
scripts/setup.sh
```

> Clone location doesn't have to be `~/projects/dotfiles`. `setup.sh` detects its own location and uses that as the dotfiles root — the paths in the managed `.zshrc` block are generated from wherever you cloned the repo. You can override with `DOTFILES=/some/path scripts/setup.sh` if you need to.

### Previewing with `--dry-run`

Before running on a machine that already has some of this set up, preview what `setup.sh` would do:

```bash
scripts/setup.sh --dry-run
```

No changes are made; every step reports either `✓ already ...` (no action needed) or `~ would ...` (describes exactly what it would do). Safe to run anywhere, including a machine you don't own.

Flags: `--dry-run` / `-n` (preview), `--help` / `-h` (usage).

`setup.sh` is idempotent — safe to re-run. It:

1. Installs Homebrew (if missing)
2. Installs required formulas: `mise`, `neovim`, `zellij`, `oh-my-posh`, `fzf`, `zoxide`, `fd`, `ripgrep`, `bat`, `eza`, `jq`, `git`
3. Installs Ghostty cask
4. Initializes git submodules (needed for `zsh-helix-mode/`)
5. Symlinks `~/.config/<tool>` → `~/projects/dotfiles/<tool>` for every managed config
6. Adds a marked-up block to `~/.zshrc` that wires in `mise`, `zoxide`, the zellij helpers, `oh-my-posh`, and `zsh-helix-mode` (replaces the block cleanly on re-runs)
7. Installs elixir-ls's official launcher (bypasses Mason's one-Elixir-version limitation)

After setup, open a new terminal tab so the new `.zshrc` is sourced.

> **Note:** `zsh-helix-mode/` is a git submodule. `setup.sh` initializes it automatically, but if you prefer to clone fully upfront: `git clone --recurse-submodules ...`.

## What gets added to your .zshrc

A managed block between `# >>> dotfiles managed block >>>` and `# <<< dotfiles managed block <<<` markers. Safe to re-run setup.sh — it replaces the block instead of appending. Your personal zshrc additions (aliases, API keys, etc.) outside that block are untouched.

The block contains:

```zsh
eval "$(mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(zoxide init zsh)"

alias zns="$HOME/projects/dotfiles/scripts/sessionizer.sh"
alias zj='...fzf into zoxide...'
alias zls='zellij list-sessions'
alias zks='zellij delete-session'
alias zsm='zellij action switch-mode session'

eval "$(oh-my-posh init zsh --config .../cyberdream.omp.json)"

export ZHM_CLIPBOARD_PIPE_CONTENT_TO="pbcopy"
export ZHM_CLIPBOARD_READ_CONTENT_FROM="pbpaste"
source "$HOME/.config/zsh-helix-mode/zsh-helix-mode.plugin.zsh"
```

## Per-project runtime versions (mise)

This config uses [mise](https://mise.jdx.dev) instead of asdf. Drop a `.tool-versions` or `.mise.toml` in any project:

```
# .tool-versions
elixir 1.19.3
erlang 28.1.1
nodejs 22.13.0
```

With `experimental = true` and `auto_install = true` in `~/.config/mise/config.toml`, `cd`-ing into a project triggers mise to install missing versions on demand.

### Why not Mason for elixir-ls?

Mason compiles elixir-ls against whichever Elixir is on PATH at install time, which breaks when you switch projects to a different Elixir. `scripts/install-elixir-ls.sh` installs the official release instead — its `language_server.sh` launcher detects mise, uses `mise which elixir` per project, and caches per-version compiles in `~/.cache/elixir-ls/`. All other LSPs stay in Mason; they're either standalone binaries or shebang-based scripts that route through mise shims correctly.

## Keybindings

Helix-style throughout Neovim. See [`KEYMAPS.md`](./KEYMAPS.md) for the full reference.

Quick highlights:

| Key | Action |
|-----|--------|
| `%` | Select entire buffer |
| `x` | Select line (extends on repeat) |
| `gh` / `gl` / `gs` | Line start / end / first non-blank |
| `gd` / `gy` / `gr` / `gi` | LSP definition / type / references / impl |
| `gw` | Jump to any visible word (flash.nvim) |
| `mm` | Matching bracket |
| `mi/ma` + `w/f/t/c/a/b` | Select inner/around textobject |
| `ms/md/mr` + pair | Add/delete/replace surround |
| `<C-n>` | Start vim-visual-multi (Helix-style selection manipulation) |
| `]d/[d` | Next/prev diagnostic |
| `]g/[g` | Next/prev git hunk |
| `<leader>f` / `<leader>F` | File picker (hidden / all) |
| `<leader>/` | Live grep workspace |
| `<leader>a` / `<leader>r` | Code action / rename |
| `:bc` / `:bca` / `:bco` | Close buffer / all / others (Helix-style) |

## Troubleshooting

### LSP / Neovim

```vim
:checkhealth
:Lazy sync
:Mason
```

### Reset mise-installed versions

```bash
mise install          # install everything in .tool-versions
mise ls               # see what's installed
```

### Reset elixir-ls

```bash
rm -rf ~/.local/share/elixir-ls ~/.cache/elixir-ls
scripts/install-elixir-ls.sh
```

### Reset managed .zshrc block

Delete the block (everything between the markers) then re-run `scripts/setup.sh`.

### Disable auto-start zellij in Ghostty / iTerm

Remove the Session block from `~/.zshrc`.

## Neovim plugin list

Core: `lazy.nvim`, `nvim-lspconfig`, `mason.nvim` (for standalone LSPs), `nvim-cmp`, `conform.nvim`, `nvim-treesitter`, `nvim-treesitter-textobjects`, `telescope.nvim`.

Editing: `mini.ai`, `mini.surround`, `mini.jump`, `mini.clue`, `mini.icons`, `vim-visual-multi`, `nvim-autopairs`, `flash.nvim`, `vim-sleuth`.

UI: `snacks.nvim` (picker/bufdelete/scroll/notifier/input), `lualine.nvim`, `bufferline.nvim`, `cyberdream.nvim`, `nvim-tree.lua`, `oil.nvim` + extensions, `gitsigns.nvim`, `garbage-day.nvim` (LSP idle cleanup), `todo-comments.nvim`.

AI: `claudecode.nvim`, `opencode.nvim`.

Terminal integration: `zellij-nav.nvim`.

## OS support

Primary target: **macOS**. The setup script uses Homebrew and assumes `pbcopy`/`pbpaste` for clipboard. Linux users would need to adapt the package installer and clipboard env vars.

## Credits

- [Helix editor](https://helix-editor.com) — keymap inspiration
- [Making Nvim Act More Like Helix with Mini.nvim](https://evantravers.com/articles/2024/09/17/making-my-nvim-act-more-like-helix-with-mini-nvim/) — starting point
- [cyberdream.nvim](https://github.com/scottmckendry/cyberdream.nvim) — colorscheme
- [snacks.nvim](https://github.com/folke/snacks.nvim), [mini.nvim](https://github.com/echasnovski/mini.nvim) — plugin families

## License

MIT
