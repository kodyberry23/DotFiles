#!/usr/bin/env bash

# Install elixir-ls's official release. The launcher included in the release
# auto-detects asdf/mise/vfox and picks up per-project Elixir/OTP versions,
# but the release's compiled .beam files are pinned to a specific Elixir
# series — so this script auto-picks an elixir-ls version matching the
# active Elixir (v0.28.0 for 1.14.x, v0.29.3 for 1.15–1.18, v0.30.0 for
# 1.19+). Run from inside a project directory so mise reports the project's
# Elixir version, not the global default.
#
# Idempotent: reinstalls only if the requested version differs from the
# currently-installed one or the launcher is missing.
#
# Overrides:
#   ELIXIR_LS_VERSION=v0.28.0  scripts/install-elixir-ls.sh   # pin directly
#   ELIXIR_VERSION=1.14.5      scripts/install-elixir-ls.sh   # pin elixir version for the lookup

set -euo pipefail

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

# Elixir series -> last compatible elixir-ls release. Update when upstream
# drops support for older Elixir versions (check release notes).
pick_elixir_ls_version() {
	local elixir_ver=$1
	case "$elixir_ver" in
		1.13.*)                           echo "v0.20.0" ;;
		1.14.*)                           echo "v0.28.0" ;;
		1.15.*|1.16.*|1.17.*|1.18.*)      echo "v0.29.3" ;;
		1.19.*|1.2*|*)                    echo "v0.30.0" ;; # default to latest for unknown/newer
	esac
}

detect_elixir_version() {
	local v=${ELIXIR_VERSION:-}
	if [[ -z "$v" ]] && has_cmd mise; then
		# mise output like "1.14.5-otp-26"; strip the -otp-NN suffix.
		v=$(mise current elixir 2>/dev/null | sed 's/-otp-[0-9]*$//')
	fi
	if [[ -z "$v" ]] && has_cmd elixir; then
		v=$(elixir --version 2>/dev/null | awk '/^Elixir/ {print $2; exit}')
	fi
	echo "$v"
}

if [[ -z "${ELIXIR_LS_VERSION:-}" ]]; then
	elixir_ver=$(detect_elixir_version)
	if [[ -n "$elixir_ver" ]]; then
		ELIXIR_LS_VERSION=$(pick_elixir_ls_version "$elixir_ver")
		info "Detected Elixir $elixir_ver → elixir-ls $ELIXIR_LS_VERSION"
	else
		ELIXIR_LS_VERSION="v0.30.0"
		warn "Could not detect Elixir version — defaulting to elixir-ls $ELIXIR_LS_VERSION"
		warn "Override with ELIXIR_VERSION=<version> or ELIXIR_LS_VERSION=<tag>"
	fi
fi

INSTALL_DIR="${ELIXIR_LS_INSTALL_DIR:-$HOME/.local/share/elixir-ls}"
RELEASE_URL="https://github.com/elixir-lsp/elixir-ls/releases/download/${ELIXIR_LS_VERSION}/elixir-ls-${ELIXIR_LS_VERSION}.zip"
LAUNCHER="$INSTALL_DIR/language_server.sh"
DEBUG_LAUNCHER="$INSTALL_DIR/debug_adapter.sh"
VERSION_FILE="$INSTALL_DIR/.installed-version"

# Skip if already installed at this version and the launcher is present.
current_version=$(cat "$VERSION_FILE" 2>/dev/null || true)
if [[ "$current_version" == "$ELIXIR_LS_VERSION" && -x "$LAUNCHER" ]]; then
	ok "elixir-ls $ELIXIR_LS_VERSION already installed at $INSTALL_DIR"
	exit 0
fi

for cmd in curl unzip; do
	if ! has_cmd "$cmd"; then
		err "required command not found: $cmd"
		exit 1
	fi
done

info "Installing elixir-ls $ELIXIR_LS_VERSION to $INSTALL_DIR"

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

curl -fsSL "$RELEASE_URL" -o "$tmpdir/elixir-ls.zip"

mkdir -p "$INSTALL_DIR"
# Wipe previous install first so a version change doesn't leave orphans.
find "$INSTALL_DIR" -mindepth 1 -delete

unzip -q "$tmpdir/elixir-ls.zip" -d "$INSTALL_DIR"
chmod +x "$LAUNCHER" "$DEBUG_LAUNCHER" 2>/dev/null || true

printf "%s" "$ELIXIR_LS_VERSION" > "$VERSION_FILE"

ok "Installed. Neovim should use: $LAUNCHER"
