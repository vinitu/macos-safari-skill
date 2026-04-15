#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "window" "new")"

usage() {
  echo "Usage: scripts/commands/window/new.sh" >&2
  echo "  Opens a new empty Safari window." >&2
}

main() {
  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
