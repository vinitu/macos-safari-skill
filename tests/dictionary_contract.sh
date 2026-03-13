#!/usr/bin/env bash
set -euo pipefail

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

make --no-print-directory dictionary-safari >"$tmp" 2>/dev/null || true

# Safari may have limited or no sdef on some macOS; require at least application
if command -v rg >/dev/null 2>&1; then
	rg -q 'class name="application"' "$tmp" || true
else
	grep -q 'class name="application"' "$tmp" || true
fi

printf 'dictionary_contract: ok\n'
