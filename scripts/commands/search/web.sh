#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=scripts/commands/_lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"

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
