#!/usr/bin/env bash

# Install elixir-ls's official release, which includes the launcher script
# that auto-detects asdf/mise/vfox and picks up per-project Elixir/OTP
# versions. Mason compiles elixir-ls against a single Elixir version at
# install time, which breaks when switching projects — this bypasses that.
#
# Idempotent: skips download if the requested version is already installed.
# Override version via env: ELIXIR_LS_VERSION=v0.30.0 scripts/install-elixir-ls.sh

set -euo pipefail

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

ELIXIR_LS_VERSION="${ELIXIR_LS_VERSION:-v0.30.0}"
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
