#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/_lib/common.sh"

BACKEND_SCRIPT="$(require_backend_script "tab" "find")"

usage() {
  echo "Usage: scripts/commands/tab/find.sh <pattern> [--focus] [--all]" >&2
  echo "  pattern  URL or title substring to search for" >&2
  echo "  --focus  switch to the first found tab" >&2
  echo "  --all    return all matching tabs as JSON array" >&2
}

main() {
  if [[ $# -eq 0 ]]; then
    usage
    json_fail "missing pattern"
  fi

  osascript "$BACKEND_SCRIPT" "$@"
}

main "$@"
