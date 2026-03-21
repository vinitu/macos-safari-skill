#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

usage() {
  echo "Usage: scripts/commands/javascript/run.sh <javascript>" >&2
}

main() {
  local backend
  local script_text="${1:-}"
  local result

  require_jq || return 1
  if [[ -z "$script_text" ]]; then
    usage
    json_fail "missing javascript" >&2
    return 1
  fi

  backend="$(require_backend_script "javascript" "run")" || return 1
  result="$(run_osascript "$backend" "$script_text")"
  json_ok "$(jq -cn --arg result "$result" '{"result":$result}')"
}

main "$@"
