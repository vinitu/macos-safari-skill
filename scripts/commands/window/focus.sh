#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "window" "focus")"

usage() {
  echo "Usage: scripts/commands/window/focus.sh <window>" >&2
  echo "  window  window index to bring to front (1-based)" >&2
}

main() {
  if [[ $# -eq 0 ]]; then
    usage
    json_fail "missing window index"
  fi
  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
