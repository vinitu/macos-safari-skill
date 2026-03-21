#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

main() {
  local backend
  local output
  local payload

  require_jq || return 1
  backend="$(require_backend_script "window" "list")" || return 1
  output="$(run_osascript "$backend")"
  payload="$(
    printf '%s' "$output" | jq -Rn '
      {
        windows: [
          inputs
          | split("\n")[]
          | select(length > 0)
          | {index: null, name: .}
        ]
        | to_entries
        | map(.value + {index: (.key + 1)})
      }'
  )"
  json_ok "$payload"
}

main "$@"
