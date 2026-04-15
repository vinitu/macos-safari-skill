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
echo "$tab_count" | grep -q '"count"' || { echo "smoke_safari: tab/count missing count key" >&2; exit 1; }

win_count="$("$ROOT_DIR/scripts/commands/window/count.sh" 2>&1)" || true
echo "$win_count" | grep -q '"count"' || { echo "smoke_safari: window/count missing count key" >&2; exit 1; }

printf '%s\n' "$tab_url" >/dev/null || true

# window/list returns JSON array with tabs_count
win_list="$("$ROOT_DIR/scripts/commands/window/list.sh" 2>&1)" || true
if [[ -n "$win_list" ]]; then
  echo "$win_list" | grep -q "tabs_count" || { echo "smoke_safari: window/list missing tabs_count" >&2; exit 1; }
fi

# window/tabs returns JSON with tabs array
win_tabs="$("$ROOT_DIR/scripts/commands/window/tabs.sh" 2>&1)" || true
if [[ -n "$win_tabs" ]]; then
  echo "$win_tabs" | grep -q "tabs" || { echo "smoke_safari: window/tabs missing tabs key" >&2; exit 1; }
fi

# tab/find.sh without args returns error JSON
find_no_args="$("$ROOT_DIR/scripts/commands/tab/find.sh" 2>&1)" || true
echo "$find_no_args" | grep -q "success\|error\|missing" || { echo "smoke_safari: tab/find missing error output" >&2; exit 1; }

# tab/find.sh with a pattern returns JSON object or error
find_out="$("$ROOT_DIR/scripts/commands/tab/find.sh" "http" 2>&1)" || true
if [[ -n "$find_out" ]]; then
  echo "$find_out" | grep -q "window\|success" || { echo "smoke_safari: tab/find unexpected output" >&2; exit 1; }
fi

# tab/find.sh --all returns JSON array
find_all="$("$ROOT_DIR/scripts/commands/tab/find.sh" "http" --all 2>&1)" || true
if [[ -n "$find_all" ]]; then
  (echo "$find_all" | grep -q '^\[' || echo "$find_all" | grep -q "success") || { echo "smoke_safari: tab/find --all unexpected output" >&2; exit 1; }
fi

# tab/focus.sh without args returns error JSON
focus_no_args="$("$ROOT_DIR/scripts/commands/tab/focus.sh" 2>&1)" || true
echo "$focus_no_args" | grep -q "success\|error\|missing" || { echo "smoke_safari: tab/focus missing error output" >&2; exit 1; }

# javascript/run.sh basic eval (Safari may return 2 or 2.0)
js_out="$("$ROOT_DIR/scripts/commands/javascript/run.sh" "1+1" 2>&1)" || true
case "$js_out" in
  2|2.0) ;;
  *) echo "smoke_safari: javascript/run.sh basic eval failed (got: $js_out)" >&2; exit 1 ;;
esac

# window/focus without args returns error JSON
focus_no_args="$("$ROOT_DIR/scripts/commands/window/focus.sh" 2>&1)" || true
echo "$focus_no_args" | grep -q "success\|error\|missing" || { echo "smoke_safari: window/focus missing error output" >&2; exit 1; }

# tab/move without args returns error JSON
move_no_args="$("$ROOT_DIR/scripts/commands/tab/move.sh" 2>&1)" || true
echo "$move_no_args" | grep -q "success\|error\|missing" || { echo "smoke_safari: tab/move missing error output" >&2; exit 1; }

# tab/list returns JSON array
tab_list_json="$("$ROOT_DIR/scripts/commands/tab/list.sh" 2>&1)" || true
if [[ -n "$tab_list_json" ]]; then
  echo "$tab_list_json" | grep -q '"index"' || { echo "smoke_safari: tab/list missing index key" >&2; exit 1; }
fi

# url/open returns JSON
open_out="$("$ROOT_DIR/scripts/commands/url/open.sh" "https://example.com" new-tab 2>&1)" || true
echo "$open_out" | grep -q "success" || { echo "smoke_safari: url/open missing success key" >&2; exit 1; }

# tab/reload, tab/duplicate, window/new — just check they exit cleanly and return JSON
reload_out="$("$ROOT_DIR/scripts/commands/tab/reload.sh" 2>&1)" || true
echo "$reload_out" | grep -q "success" || { echo "smoke_safari: tab/reload unexpected output" >&2; exit 1; }

duplicate_out="$("$ROOT_DIR/scripts/commands/tab/duplicate.sh" 2>&1)" || true
echo "$duplicate_out" | grep -q "success" || { echo "smoke_safari: tab/duplicate unexpected output" >&2; exit 1; }

# tab/url and tab/title with --window --tab
url_w_out="$("$ROOT_DIR/scripts/commands/tab/url.sh" --window 1 --tab 1 2>&1)" || true
printf '%s\n' "$url_w_out" >/dev/null || true

title_w_out="$("$ROOT_DIR/scripts/commands/tab/title.sh" --window 1 --tab 1 2>&1)" || true
printf '%s\n' "$title_w_out" >/dev/null || true

# reading-list/add without args returns error JSON
rl_out="$("$ROOT_DIR/scripts/commands/reading-list/add.sh" 2>&1)" || true
echo "$rl_out" | grep -q "success\|error\|missing" || { echo "smoke_safari: reading-list/add unexpected output" >&2; exit 1; }

# search/the-web without args returns error JSON
search_out="$("$ROOT_DIR/scripts/commands/search/the-web.sh" 2>&1)" || true
echo "$search_out" | grep -q "success\|error\|missing" || { echo "smoke_safari: search/the-web unexpected output" >&2; exit 1; }

echo "smoke_safari: ok"
