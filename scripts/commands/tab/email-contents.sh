#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

main() {
  local backend

  require_jq || return 1
  backend="$(require_backend_script "tab" "email-contents")" || return 1
  run_osascript "$backend" >/dev/null
  json_ok "$(jq -cn '{"opened":true,"kind":"mail-compose"}')"
}

main "$@"
