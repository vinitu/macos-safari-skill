#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

main() {
  local backend
  local tab_index="${1:-}"
  local result

  require_jq || return 1
  backend="$(require_backend_script "tab" "title")" || return 1
  if [[ -n "$tab_index" ]]; then
    result="$(run_osascript "$backend" "$tab_index")"
  else
    result="$(run_osascript "$backend")"
  fi

  json_ok "$(jq -cn --arg title "$result" '{"title":$title}')"
}

main "$@"
