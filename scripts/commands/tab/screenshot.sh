#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "tab" "screenshot")"

usage() {
  echo "Usage: scripts/commands/tab/screenshot.sh [--output path] [--window N] [--tab N]" >&2
  echo "  --output path  save path (default: /tmp/safari-screenshot.png)" >&2
  echo "  --window N     target window index (default: front window)" >&2
  echo "  --tab N        target tab index (switches to it first)" >&2
}

main() {
  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
