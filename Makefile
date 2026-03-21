.PHONY: dictionary-safari compile check test test-dictionary test-smoke

dictionary-safari:
	@sdef /System/Applications/Safari.app 2>/dev/null || true

compile:
	@set -euo pipefail; \
	find scripts/applescripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file"; \
	done
	@if command -v shellcheck >/dev/null 2>&1; then \
		find scripts/commands tests -name '*.sh' -print0 | xargs -0 shellcheck -x -e SC1091; \
	else \
		echo "shellcheck not available, skipping"; \
	fi

check:
	@command -v jq >/dev/null 2>&1 || { echo "check: jq is required"; exit 1; }
	@osascript -e 'tell application "Safari" to get name' >/dev/null || { echo "check: Safari not available"; exit 1; }
	@echo "Safari is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_safari.sh
