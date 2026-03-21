#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

usage() {
  echo "Usage: scripts/commands/reading-list/add.sh <url> [preview] [title]" >&2
}

main() {
  local backend
  local url="${1:-}"
  local preview="${2:-}"
  local title="${3:-}"

  require_jq || return 1
  if [[ -z "$url" ]]; then
    usage
    json_fail "missing url" >&2
    return 1
  fi

  backend="$(require_backend_script "reading-list" "add")" || return 1
  run_osascript "$backend" "$url" "$preview" "$title" >/dev/null
  json_ok "$(jq -cn --arg url "$url" '{"added":true,"url":$url}')"
}

main "$@"
