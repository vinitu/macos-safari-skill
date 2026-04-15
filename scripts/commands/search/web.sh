#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

usage() {
  echo "Usage: scripts/commands/search/web.sh <query>" >&2
}

main() {
  local backend
  local query="${1:-}"

  require_jq || return 1
  if [[ -z "$query" ]]; then
    usage
    json_fail "missing query" >&2
    return 1
  fi

  backend="$(require_backend_script "search" "web")" || return 1
  run_osascript "$backend" "$query" >/dev/null
  json_ok "$(jq -cn --arg query "$query" '{"searched":true,"query":$query}')"
}

main "$@"
