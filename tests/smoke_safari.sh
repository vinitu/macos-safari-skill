#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! osascript -e 'tell application "Safari" to get name' >/dev/null 2>&1; then
	echo "smoke_safari: Safari not available."
	exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
	echo "smoke_safari: jq not available."
	exit 0
fi

tab_list_json="$(bash "$ROOT_DIR/scripts/commands/tab/list.sh" 2>/dev/null)" || { echo "smoke_safari: Safari not running, skipping."; exit 0; }
tab_url_json="$(bash "$ROOT_DIR/scripts/commands/tab/url.sh" 2>/dev/null)" || true
tab_count_json="$(bash "$ROOT_DIR/scripts/commands/tab/count.sh" 2>/dev/null)" || true
win_count_json="$(bash "$ROOT_DIR/scripts/commands/window/count.sh" 2>/dev/null)" || true

printf '%s\n' "$tab_list_json" "$tab_url_json" "$tab_count_json" "$win_count_json" | jq empty >/dev/null || {
	echo "smoke_safari: command output is not valid JSON." >&2
	exit 1
}

echo "smoke_safari: ok"
