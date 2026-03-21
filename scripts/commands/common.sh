#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

json_fail() {
  local message="$1"
  jq -cn --arg error "$message" '{"success":false,"error":$error}'
}

json_ok() {
  local payload="${1:-}"
  if [[ -z "$payload" ]]; then
    payload='{}'
  fi
  jq -cn --argjson data "$payload" '{"success":true,"data":$data}'
}

require_arg() {
  local value="${1:-}"
  local label="$2"

  if [[ -z "$value" ]]; then
    json_fail "missing ${label}"
    return 1
  fi
}

require_jq() {
  if ! command -v jq >/dev/null 2>&1; then
    json_fail "jq is required"
    return 1
  fi
}

backend_script() {
  local entity="$1"
  local action="$2"
  printf '%s/scripts/applescripts/%s/%s.applescript' "$ROOT_DIR" "$entity" "$action"
}

require_backend_script() {
  local entity="$1"
  local action="$2"
  local path

  path="$(backend_script "$entity" "$action")"
  if [[ ! -f "$path" ]]; then
    json_fail "backend script not found"
    return 1
  fi

  printf '%s\n' "$path"
}

run_osascript() {
  local script_path="$1"
  shift

  osascript "$script_path" "$@"
}

json_array_from_lines() {
  local key="$1"
  local input="${2:-}"

  jq -Rn --arg key "$key" --arg input "$input" '
    {
      ($key): (
        if $input == "" then
          []
        else
          ($input | split("\n") | map(select(length > 0)))
        end
      )
    }'
}
