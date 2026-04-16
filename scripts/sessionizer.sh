#!/usr/bin/env bash

# Zellij sessionizer — create/attach a session named after a chosen directory.
# Usage: sessionizer.sh [path]
# - If a path arg is provided, use it.
# - Otherwise, pick from PROJECT_ROOTS via fzf (combines recent dirs from zoxide).
# - Handles switching sessions when already inside zellij.

set -euo pipefail

err() { printf "sessionizer: %s\n" "$*" >&2; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

if ! has_cmd zellij; then
	err "zellij not found in PATH"
	exit 1
fi

PROJECT_ROOTS=("$HOME/projects")

# Choose directory
if [[ $# -eq 1 ]]; then
	selected=$(cd "$1" 2>/dev/null && pwd) || { err "invalid path: $1"; exit 1; }
else
	if has_cmd fzf && has_cmd fd; then
		# Combine project directories with zoxide frecent directories
		project_dirs=$(fd -H -t d -d 1 . "${PROJECT_ROOTS[@]}" 2>/dev/null || true)
		
		# Add frecent directories from zoxide (if available)
		if has_cmd zoxide; then
			zoxide_dirs=$(zoxide query -l 2>/dev/null | grep -E "^($HOME/projects)" || true)
			# Combine and deduplicate
			candidates=$(printf '%s\n%s\n' "$project_dirs" "$zoxide_dirs" | awk '!seen[$0]++')
		else
			candidates=$project_dirs
		fi
		
		if [[ -n ${candidates:-} ]]; then
			selected=$(printf '%s\n' "$candidates" | fzf \
				--prompt="📁 Select Project > " \
				--header="Recent & Project Directories (Ctrl-/ toggle preview)" \
				--preview='eza -la --color=always --icons --git {} 2>/dev/null || ls -la --color=always {} 2>/dev/null || tree -L 1 -C {} 2>/dev/null || echo "Preview unavailable"' \
				--preview-window=right:50%:wrap)
		fi
	fi
	# fallback to first project root or current directory
	if [[ -z ${selected:-} ]]; then
		if [[ -d ${PROJECT_ROOTS[0]:-} ]]; then
			selected="${PROJECT_ROOTS[0]}"
		else
			selected=$(pwd)
		fi
	fi
fi

# Abort if nothing
if [[ -z ${selected:-} ]]; then
	err "no selection"
	exit 1
fi

# Add to zoxide for frecency tracking
if has_cmd zoxide; then
	zoxide add "$selected" 2>/dev/null || true
fi

session_name=$(basename "$selected" | tr ' .' '_')

# zellij-switch plugin for in-session switching (auto-downloaded & cached)
ZELLIJ_SWITCH_URL="https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm"

# If inside a live zellij session, switch via plugin.
# Uses timeout because $ZELLIJ can be stale after exiting zellij — if the
# pipe hangs or fails (dead/stuck server, stale env), we fall through to
# a fresh attach below instead of calling list-sessions (which probes ALL
# servers and hangs if any one of them is unresponsive).
if [[ -n ${ZELLIJ:-} ]]; then
	if timeout 5 zellij pipe --plugin "$ZELLIJ_SWITCH_URL" -- "-s ${session_name} --cwd ${selected}" &>/dev/null; then
		exit 0
	fi
fi

# Attach to existing session or create a new one.
# No kill-session needed: closing a terminal sends SIGHUP which closes the
# client socket immediately; zellij detects the dead client within one event
# loop cycle and resizes panes to the remaining (new) client's dimensions.
cd "$selected"
exec zellij attach --create "$session_name"
