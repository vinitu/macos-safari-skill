.PHONY: dictionary-safari compile check test test-dictionary test-smoke

dictionary-safari:
	@sdef /System/Applications/Safari.app 2>/dev/null || true

compile:
	@set -euo pipefail; \
	find scripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file"; \
	done

check:
	@osascript -e 'tell application "Safari" to get name' >/dev/null || { echo "check: Safari not available"; exit 1; }
	@echo "Safari is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_safari.sh
