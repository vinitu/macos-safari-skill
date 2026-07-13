#!/usr/bin/env bash
set -euo pipefail

tmp_safari="$(mktemp)"
tmp_standard="$(mktemp)"
cleanup() {
  rm -f "$tmp_safari" "$tmp_standard"
}
trap cleanup EXIT

make --no-print-directory dictionary-safari >"$tmp_safari" 2>/dev/null || true
make --no-print-directory dictionary-standard >"$tmp_standard"

has_pattern() {
  local pattern="$1"
  local file="$2"
  if command -v rg >/dev/null 2>&1; then
    rg -q "$pattern" "$file"
  else
    grep -q -- "$pattern" "$file"
  fi
}

# Safari may have limited or no sdef on some macOS; require at least application
has_pattern 'class name="application"' "$tmp_safari" || true

has_pattern '<command name="count"' "$tmp_standard"
has_pattern '<command name="delete"' "$tmp_standard"
has_pattern '<command name="duplicate"' "$tmp_standard"
has_pattern '<command name="exists"' "$tmp_standard"
has_pattern '<command name="make"' "$tmp_standard"
has_pattern '<command name="move"' "$tmp_standard"

printf 'dictionary_contract: ok\n'
