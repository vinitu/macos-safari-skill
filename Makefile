.PHONY: dictionary dictionary-safari dictionary-standard compile check test test-dictionary test-smoke

dictionary:
	@printf '### Safari.app\n'
	@sdef /Applications/Safari.app 2>/dev/null || true
	@printf '\n### CocoaStandard.sdef\n'
	@cat /System/Library/ScriptingDefinitions/CocoaStandard.sdef

dictionary-safari:
	@sdef /Applications/Safari.app 2>/dev/null || true

dictionary-standard:
	@cat /System/Library/ScriptingDefinitions/CocoaStandard.sdef

compile:
	@set -euo pipefail; \
	find scripts/applescripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file" || exit 1; \
	done; \
	find tests scripts/commands -name '*.sh' -print | while IFS= read -r file; do \
		bash -n "$$file" || exit 1; \
	done

check:
	@osascript -e 'tell application "Safari" to get name' >/dev/null || { echo "check: Safari not available"; exit 1; }
	@echo "Safari is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_safari.sh
