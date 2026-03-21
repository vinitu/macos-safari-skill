#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

main() {
  local backend
  local result

  require_jq || return 1
  backend="$(require_backend_script "tab" "source")" || return 1
  result="$(run_osascript "$backend")"
  json_ok "$(jq -cn --arg source "$result" '{"source":$source}')"
}

main "$@"
