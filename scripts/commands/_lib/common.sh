#!/usr/bin/env bash

# Use common.sh only for logic shared by two or more public commands.
# Keep common.sh small and focused on reusable shell helpers.
# Put path resolution, JSON helpers, error helpers, and shared backend lookup here.
# Do not put command-specific business logic here.
# Do not hide the public command contract inside common.sh.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

json_fail() {
  local message="$1"
  printf '{"success":false,"error":"%s"}\n' "$message"
  exit 1
}

json_ok() {
  local payload="$1"
  printf '{"success":true,"data":%s}\n' "$payload"
}

require_arg() {
  local value="${1:-}"
  local label="$2"

  if [[ -z "$value" ]]; then
    json_fail "missing ${label}"
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
    json_fail "backend script not found: $path"
  fi

  printf '%s\n' "$path"
}
