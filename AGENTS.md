# Repo Guide

This repo stores a skill for automating macOS Safari.

## Goal

- Document AppleScript commands for Safari automation accurately.
- Prefer runnable examples over long prose.
- Never open URLs or execute JavaScript without explicit user approval.

## Repo Layout

- `AGENTS.md`: this file; rules for coding agents.
- `SKILL.md`: the skill contract and usage instructions for agents.
- `README.md` is the repo overview for humans.
- `Makefile`: targets `dictionary-safari`, `check`, `compile`, `test` (test-dictionary + test-smoke).
- `scripts/tab/list.applescript`, `url.applescript`, `title.applescript`, `source.applescript`, `count.applescript`, `close.applescript`, `email-contents.applescript`.
- `scripts/window/list.applescript`, `count.applescript`, `close.applescript`.
- `scripts/url/open.applescript`; `scripts/javascript/run.applescript`; `scripts/reading-list/add.applescript`.
- `scripts/search-the-web.applescript`; `scripts/bookmarks/show.applescript`.
- `tests/dictionary_contract.sh`: contract test against Safari scripting dictionary.
- `tests/smoke_safari.sh`: smoke test for script layer (skips when Safari not available).
- `.github/workflows/ci-pr.yml`: PR validation, auto-merge, version bump, tag, and release flow.
- `.github/workflows/ci-main.yml`: main-branch validation, patch tag, and release flow.

## Validation

After making changes:
- run `make check` to ensure Safari is available;
- run `make test` to run dictionary contract and smoke tests;
- run `make compile` to compile all AppleScript files (syntax check);
- update `SKILL.md` when command coverage changes.

## Editing Rules

- Keep docs in simple English.
- Do not claim support for a feature unless it is verified with Safari's AppleScript dictionary.
- Never open URLs or execute JavaScript without explicit user approval.
