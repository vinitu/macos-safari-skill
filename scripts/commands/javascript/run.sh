#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(backend_script "javascript" "run")"

usage() {
  echo "Usage: scripts/commands/javascript/run.sh <script> [tab-index]" >&2
}

main() {
  if [[ ! -f "$BACKEND_SCRIPT" ]]; then
    json_fail "backend script not found: $BACKEND_SCRIPT"
  fi

  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
