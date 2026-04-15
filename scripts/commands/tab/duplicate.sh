#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "tab" "duplicate")"

usage() {
  echo "Usage: scripts/commands/tab/duplicate.sh [--window N] [--tab N]" >&2
  echo "  --window N  source window index (default: front window)" >&2
  echo "  --tab N     source tab index (default: current tab)" >&2
}

main() {
  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
