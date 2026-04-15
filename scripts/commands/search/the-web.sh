#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(backend_script "search" "the-web")"

usage() {
  echo "Usage: scripts/commands/search/the-web.sh <query>" >&2
}

main() {
  if [[ ! -f "$BACKEND_SCRIPT" ]]; then
    json_fail "backend script not found: $BACKEND_SCRIPT"
  fi

  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
