#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "window" "tabs")"

usage() {
  echo "Usage: scripts/commands/window/tabs.sh [window]" >&2
  echo "  window  window index (1-based); omit to list all windows" >&2
}

main() {
  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
