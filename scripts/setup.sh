#!/usr/bin/env bash

# Bootstrap this dotfiles repo on a fresh macOS machine (and re-run safely
# on an already-configured one — every step is idempotent).
#
# Usage:
#   scripts/setup.sh              # actually make changes
#   scripts/setup.sh --dry-run    # preview without touching anything
#   scripts/setup.sh -n           # same as --dry-run
#   scripts/setup.sh -h | --help  # usage

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib/common.sh"

# DOTFILES resolves to the repo root (scripts/setup.sh -> repo root).
# Works regardless of where the user cloned; DOTFILES env var overrides.
DOTFILES="${DOTFILES:-$(cd "$SCRIPT_DIR/.." && pwd)}"
ZSHRC="$HOME/.zshrc"
ZPROFILE="$HOME/.zprofile"
MARKER_START="# >>> dotfiles managed block >>>"
MARKER_END="# <<< dotfiles managed block <<<"

usage() {
	cat <<'USAGE'
Bootstrap this dotfiles repo on a fresh macOS machine (and re-run safely
on an already-configured one — every step is idempotent).

What it does:
  1. Installs Homebrew if missing
  2. Installs required Homebrew packages
  3. Initializes git submodules
  4. Symlinks ~/.config/<name> -> <dotfiles>/<name>
  5. Adds a managed block to ~/.zshrc that wires up mise, zellij helpers,
     oh-my-posh, and zsh-helix-mode (replaces old block if present)
  6. Adds a managed block to ~/.zprofile that prepends mise shims for
     non-interactive login shells (tmux startup, `zsh -l` scripts)
  7. Runs scripts/install-elixir-ls.sh

Usage:
  scripts/setup.sh              actually make changes
  scripts/setup.sh --dry-run    preview without touching anything
  scripts/setup.sh -n           same as --dry-run
  scripts/setup.sh -h | --help  this message
USAGE
}

DRY_RUN=false
for arg in "$@"; do
	case "$arg" in
		--dry-run|-n) DRY_RUN=true ;;
		-h|--help)    usage; exit 0 ;;
		*)            err "unknown argument: $arg"; exit 2 ;;
	esac
done

if [[ ! -d "$DOTFILES" ]]; then
	err "dotfiles not found at $DOTFILES"
	err "clone the repo first or set DOTFILES=<path>"
	exit 1
fi

if [[ "$(uname)" != "Darwin" ]]; then
	warn "this script targets macOS; some steps may not apply on $(uname)"
fi

if $DRY_RUN; then
	info "DRY RUN — no changes will be made"
	echo
fi

install_homebrew() {
	info "Homebrew"
	if has_cmd brew; then
		ok "already installed"
		return
	fi
	if $DRY_RUN; then
		would "install Homebrew from https://brew.sh"
		return
	fi
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Apple Silicon: brew lives in /opt/homebrew, add to PATH for this session.
	if [[ -x /opt/homebrew/bin/brew ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi
	ok "installed"
}

install_brew_packages() {
	info "Homebrew packages"
	# curl and unzip are provided by macOS; no need to brew-install them.
	local formulas=(mise neovim zellij oh-my-posh fzf zoxide fd ripgrep bat eza jq git)
	local casks=(ghostty)

	if ! has_cmd brew; then
		if $DRY_RUN; then
			would "install formulas: ${formulas[*]}"
			would "install casks: ${casks[*]}"
			return
		fi
		err "brew missing; install_homebrew() should have handled this"
		return 1
	fi

	# macOS ships bash 3.2 — no associative arrays. Capture the full lists
	# once as newline-separated strings and probe with `grep -qFx`.
	local installed_formulas installed_casks
	installed_formulas=$(brew list --formula -1 2>/dev/null || true)
	installed_casks=$(brew list --cask -1 2>/dev/null || true)

	# Check common non-brew install locations so we don't reinstall tools
	# users have gotten another way (system package, cargo/go install, mise's
	# own installer, direct .dmg download for casks, etc.).
	_have_outside_brew() {
		local pkg=$1 kind=$2
		if [[ $kind == formula ]]; then
			case "$pkg" in
				neovim)  has_cmd nvim ;;
				ripgrep) has_cmd rg ;;
				*)       has_cmd "$pkg" ;;
			esac
		else
			case "$pkg" in
				ghostty) [[ -d /Applications/Ghostty.app ]] ;;
				*)       false ;;
			esac
		fi
	}

	_install() {
		local pkg=$1 kind=$2 list=$3 flag=${4-}
		local label=$pkg; [[ $kind == cask ]] && label="$pkg cask"

		if grep -qFx "$pkg" <<<"$list"; then
			ok "$label (already installed via brew)"
		elif _have_outside_brew "$pkg" "$kind"; then
			ok "$label (already installed outside brew)"
		elif $DRY_RUN; then
			would "install $label"
		else
			info "  installing $label"
			brew install $flag "$pkg"
		fi
	}

	for pkg in "${formulas[@]}"; do _install "$pkg" formula "$installed_formulas"; done
	for pkg in "${casks[@]}";    do _install "$pkg" cask    "$installed_casks" --cask; done
	unset -f _install _have_outside_brew
}

init_submodules() {
	info "Git submodules"
	if [[ ! -f "$DOTFILES/.gitmodules" ]]; then
		ok "no submodules declared"
		return
	fi
	if ! has_cmd git; then
		warn "git not on PATH — skipping submodule init"
		return
	fi

	# Submodule status lines prefixed with `-` are uninitialized, `+` out of sync.
	local status
	status=$(git -C "$DOTFILES" submodule status 2>/dev/null || true)
	if ! grep -qE '^[-+]' <<<"$status"; then
		ok "up to date"
		return
	fi

	if $DRY_RUN; then
		would "run 'git submodule update --init --recursive'"
		return
	fi
	git -C "$DOTFILES" submodule update --init --recursive
	ok "up to date"
}

ensure_symlink() {
	local src=$1 dst=$2
	if [[ -L "$dst" ]]; then
		local current
		current=$(readlink "$dst")
		if [[ "$current" == "$src" ]]; then
			ok "$(basename "$dst") (already linked)"
			return
		fi
		warn "$dst points to $current"
		if $DRY_RUN; then
			would "replace symlink: $dst -> $src"
		else
			rm "$dst"
			ln -s "$src" "$dst"
			ok "$(basename "$dst") -> $src (replaced)"
		fi
		return
	elif [[ -e "$dst" ]]; then
		warn "$dst exists and is not a symlink"
		warn "  move or delete it, then re-run setup.sh"
		return
	fi

	if $DRY_RUN; then
		would "create symlink: $dst -> $src"
		return
	fi
	mkdir -p "$(dirname "$dst")"
	ln -s "$src" "$dst"
	ok "$(basename "$dst") -> $src"
}

symlink_configs() {
	info "~/.config symlinks"
	local names=(nvim ghostty zellij oh-my-posh zsh-helix-mode helix)
	for name in "${names[@]}"; do
		if [[ -d "$DOTFILES/$name" ]]; then
			ensure_symlink "$DOTFILES/$name" "$HOME/.config/$name"
		else
			warn "$DOTFILES/$name not found, skipping"
		fi
	done
}

zshrc_block() {
	# Heredoc is single-quoted so $(...) and $HOME stay literal (they expand
	# at .zshrc load time). __DOTFILES__ is our substitution placeholder.
	local block
	block=$(cat <<'EOF'
# >>> dotfiles managed block >>>
# Managed by __DOTFILES__/scripts/setup.sh — re-run setup.sh to update.
# Remove these markers and the lines between to disable.

# Runtime version management (mise replaces asdf)
eval "$(mise activate zsh)"
# Mise shims prepended after homebrew PATH so mise-managed versions win
export PATH="$HOME/.local/share/mise/shims:$PATH"

# zoxide — required by the `zj` alias below
eval "$(zoxide init zsh)"

# Zellij sessionizer + helpers
alias zns="__DOTFILES__/scripts/sessionizer.sh"
alias zj='cd $(zoxide query -l | fzf --prompt="📍 Jump to > " --preview="eza -la --icons {}" --preview-window=right:50%) && zns .'
alias zls='zellij list-sessions'
alias zks='zellij delete-session'
alias zsm='zellij action switch-mode session'

# oh-my-posh prompt (cyberdream theme from dotfiles)
eval "$(oh-my-posh init zsh --config __DOTFILES__/oh-my-posh/cyberdream.omp.json)"

# zsh-helix-mode (Helix-style line editor in zsh)
export ZHM_CLIPBOARD_PIPE_CONTENT_TO="pbcopy"
export ZHM_CLIPBOARD_READ_CONTENT_FROM="pbpaste"
source "$HOME/.config/zsh-helix-mode/zsh-helix-mode.plugin.zsh"

# <<< dotfiles managed block <<<
EOF
)
	printf "%s" "${block//__DOTFILES__/$DOTFILES}"
}

zprofile_block() {
	# .zprofile runs for login shells (incl. non-interactive ones like tmux
	# startup scripts or `zsh -l -c ...`). Prepending mise shims here means
	# mise-managed runtimes are on PATH even when .zshrc doesn't run.
	# macOS GUI app launches (Spotlight, Finder) do NOT read .zprofile —
	# nvim/init.lua handles that case separately.
	local block
	block=$(cat <<'EOF'
# >>> dotfiles managed block >>>
# Managed by __DOTFILES__/scripts/setup.sh — re-run setup.sh to update.
# Remove these markers and the lines between to disable.

# Mise shims for non-interactive login shells (tmux, `zsh -l`, etc.)
export PATH="$HOME/.local/share/mise/shims:$PATH"

# <<< dotfiles managed block <<<
EOF
)
	printf "%s" "${block//__DOTFILES__/$DOTFILES}"
}

# Install/update a managed block in a dotfile. $1 = target path, $2 = name of
# function that emits the block body.
setup_managed_block() {
	local target=$1 block_fn=$2
	local label="$(basename "$target") managed block"
	info "$label"

	if $DRY_RUN && [[ ! -f "$target" ]]; then
		would "create $target with managed block"
		return
	fi
	touch "$target"

	local new_block
	new_block=$("$block_fn")

	if grep -qF "$MARKER_START" "$target"; then
		local current_block
		current_block=$(awk -v s="$MARKER_START" -v e="$MARKER_END" '
			$0 ~ s { inside=1 }
			inside { print }
			$0 ~ e { inside=0 }
		' "$target")
		if [[ "$current_block" == "$new_block" ]]; then
			ok "already up to date"
			return
		fi

		if $DRY_RUN; then
			would "replace existing managed block in $target"
			return
		fi

		local tmp
		tmp=$(mktemp)
		awk -v s="$MARKER_START" -v e="$MARKER_END" -v new="$new_block" '
			$0 ~ s { skip=1; next }
			$0 ~ e { skip=0; next }
			!skip  { print }
			END    { printf "\n%s\n", new }
		' "$target" > "$tmp"
		mv "$tmp" "$target"
		ok "updated (existing block replaced)"
	else
		if $DRY_RUN; then
			would "append managed block to $target"
			return
		fi
		printf "\n%s\n" "$new_block" >> "$target"
		ok "added"
	fi
}

install_elixir_ls() {
	info "elixir-ls (official launcher)"
	if $DRY_RUN; then
		# install-elixir-ls.sh is idempotent; read its version marker to
		# predict whether it would do anything.
		local version
		if version=$(cat "$HOME/.local/share/elixir-ls/.installed-version" 2>/dev/null); then
			ok "already installed ($version)"
		else
			would "run $DOTFILES/scripts/install-elixir-ls.sh"
		fi
		return
	fi
	"$DOTFILES/scripts/install-elixir-ls.sh"
}

main() {
	install_homebrew
	install_brew_packages
	init_submodules
	symlink_configs
	setup_managed_block "$ZSHRC" zshrc_block
	setup_managed_block "$ZPROFILE" zprofile_block
	install_elixir_ls

	echo
	if $DRY_RUN; then
		info "Dry-run complete — no changes made"
		echo "  Re-run without --dry-run to apply."
	else
		info "Done"
		echo
		echo "Next steps:"
		echo "  1. Open a new terminal tab (so the new .zshrc is sourced)"
		echo "  2. Run: mise install      (in any directory with a .tool-versions)"
		echo "  3. Launch nvim — lazy.nvim will fetch plugins on first run"
	fi
}

main "$@"
