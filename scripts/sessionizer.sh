#!/usr/bin/env bash

# Zellij sessionizer — create/attach a session named after a chosen directory.
# Usage: sessionizer.sh [path]
# - If a path arg is provided, use it.
# - Otherwise, pick from PROJECT_ROOTS via fzf (combines recent dirs from zoxide).
# - Handles switching sessions when already inside zellij.
# - Auto-cleans up dead sessions.

set -euo pipefail

err() { printf "sessionizer: %s\n" "$*" >&2; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Check if a zellij session exists and is not in EXITED state.
is_zellij_session_alive() {
	local name="$1"
	[[ -n "$name" ]] || return 1
	local line
	line=$(zellij list-sessions --no-formatting 2>/dev/null | grep "^${name} ") || return 1
	[[ "$line" != *"EXITED"* ]]
}

# Poll until a session is fully gone (max ~5 seconds).
wait_for_session_gone() {
	local name="$1"
	local attempts=0
	while zellij list-sessions --short --no-formatting 2>/dev/null | grep -qx "$name"; do
		if (( attempts >= 25 )); then
			err "timed out waiting for session '$name' to terminate"
			return 1
		fi
		sleep 0.2
		(( attempts++ ))
	done
}

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

# Check if we're truly inside a live zellij session.
# $ZELLIJ can be stale after exiting zellij — verify the session is alive.
if [[ -n ${ZELLIJ:-} ]] && is_zellij_session_alive "${ZELLIJ_SESSION_NAME:-}"; then
	# Zellij has no native CLI action to switch sessions.
	# Use the zellij-switch plugin via pipe to call the internal
	# switch_session_with_layout() API.
	exec zellij pipe --plugin "$ZELLIJ_SWITCH_URL" -- "-s ${session_name} --cwd ${selected}"
else
	# Clean up dead/exited sessions
	while IFS= read -r line; do
		if [[ "$line" == *"EXITED"* ]]; then
			zellij delete-session "${line%% *}" &>/dev/null || true
		fi
	done < <(zellij list-sessions --no-formatting 2>/dev/null || true)

	# Kill existing session to prevent stale client sizing issues.
	# Zellij has no way to detach stale clients — a zombie client from a
	# previously closed terminal holds outdated dimensions, causing panes
	# to get stuck at the wrong size on resize.
	if is_zellij_session_alive "$session_name"; then
		zellij kill-session "$session_name" &>/dev/null || true
		wait_for_session_gone "$session_name" || true
		# Clean up the now-exited session
		zellij delete-session "$session_name" &>/dev/null || true
	fi

	cd "$selected"
	exec zellij attach --create "$session_name"
fi
