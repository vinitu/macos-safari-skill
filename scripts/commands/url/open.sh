#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_SH="$SCRIPT_DIR/../common.sh"
# shellcheck source=../common.sh
source "$COMMON_SH"

usage() {
  echo "Usage: scripts/commands/url/open.sh <url> [current-tab|new-tab|new-window]" >&2
}

main() {
  local backend
  local url="${1:-}"
  local target="${2:-new-tab}"

  require_jq || return 1
  if [[ -z "$url" ]]; then
    usage
    json_fail "missing url" >&2
    return 1
  fi

  case "$target" in
    current-tab|new-tab|new-window) ;;
    *)
      json_fail "invalid target" >&2
      return 1
      ;;
  esac

  backend="$(require_backend_script "url" "open")" || return 1
  run_osascript "$backend" "$url" "$target" >/dev/null
  json_ok "$(jq -cn --arg url "$url" --arg target "$target" '{"opened":true,"url":$url,"target":$target}')"
}

main "$@"
