#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "tab" "focus")"

usage() {
  echo "Usage: scripts/commands/tab/focus.sh <window> <tab>" >&2
  echo "  window  window index (1-based)" >&2
  echo "  tab     tab index (1-based)" >&2
}

main() {
  if [[ $# -lt 2 ]]; then
    usage
    json_fail "missing window or tab index"
  fi

  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
