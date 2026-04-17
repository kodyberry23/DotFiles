# shellcheck shell=bash
# Shared helpers for scripts in ~/projects/dotfiles/scripts.
# Source this from the top of each script:
#   . "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

info()  { printf "\033[34m==>\033[0m %s\n"    "$*";        }
ok()    { printf "\033[32m  ✓\033[0m %s\n"    "$*";        }
warn()  { printf "\033[33m  !\033[0m %s\n"    "$*" >&2;    }
err()   { printf "\033[31m  ✗\033[0m %s\n"    "$*" >&2;    }
would() { printf "\033[36m  ~\033[0m would %s\n" "$*";     }

has_cmd() { command -v "$1" >/dev/null 2>&1; }
