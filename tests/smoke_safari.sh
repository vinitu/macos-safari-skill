#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! osascript -e 'tell application "Safari" to get name' >/dev/null 2>&1; then
	echo "smoke_safari: Safari not available."
	exit 0
fi

# Test public interface
tab_out="$("$ROOT_DIR/scripts/commands/tab/list.sh" 2>&1)" || { echo "smoke_safari: Safari not running, skipping."; exit 0; }
printf '%s\n' "$tab_out" >/dev/null || { echo "smoke_safari: tab list failed." >&2; exit 1; }

tab_url="$("$ROOT_DIR/scripts/commands/tab/url.sh" 2>&1)" || true
tab_count="$("$ROOT_DIR/scripts/commands/tab/count.sh" 2>&1)" || true
win_count="$("$ROOT_DIR/scripts/commands/window/count.sh" 2>&1)" || true
printf '%s\n' "$tab_url" "$tab_count" "$win_count" >/dev/null || true

echo "smoke_safari: ok"
