#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(backend_script "tab" "url")"

usage() {
  echo "Usage: scripts/commands/tab/url.sh [--window N] [--tab N]" >&2
  echo "  --window N  target window index (default: front window)" >&2
  echo "  --tab N     target tab index (default: current tab)" >&2
}

main() {
  if [[ ! -f "$BACKEND_SCRIPT" ]]; then
    json_fail "backend script not found: $BACKEND_SCRIPT"
  fi

  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
