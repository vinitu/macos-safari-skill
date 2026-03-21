# Repo Guide

This repo stores an AI agent skill for automating Safari on macOS.
Installed global skill directory: `~/.agents/skills/macos-safari`.
Package source: `vinitu/macos-safari-skill`.

## Where to start

- Read this file, then `SKILL.md` for the public command list and output rules.
- Run public commands from the repo root via `scripts/commands/...`.
- Do not call `scripts/applescripts` directly. It is internal implementation only.

## Goal

- Keep the public `scripts/commands` contract stable.
- Keep the AppleScript coverage aligned with Safari's scripting dictionary.
- Keep write actions explicit and clearly documented.
- Never open URLs or execute JavaScript without explicit user approval.

## Source of truth

- `SKILL.md` for the public command contract and JSON output rules.
- `README.md` for install, package naming, repo layout, validation flow, and limits.
- `make dictionary-safari` and live `osascript` checks for Safari dictionary coverage.

## Repo layout

- `SKILL.md` — main skill workflow and command reference.
- `README.md` — human-facing repo overview.
- `scripts/commands/` — public shell command interface.
- `scripts/applescripts/` — internal AppleScript backends.
- `tests/` — dictionary contract and smoke checks.
- `.github/workflows/ci-pr.yml` — PR validation, auto-merge, version bump, tag, and release flow.
- `.github/workflows/ci-main.yml` — main-branch validation, patch tag, and release flow.

## Working rules

- Public commands live only in `scripts/commands/**`.
- Keep `scripts/applescripts/**` internal. Do not document it as public API.
- Return machine-readable JSON from public commands.
- Keep `jq` as the only extra runtime dependency beyond macOS tools.
- If you change command coverage or output shape, update both `SKILL.md` and `README.md`.
- Never open URLs, run page JavaScript, or modify Reading List without explicit user approval.

## Validation

- After changes: run `make check`, then `make compile`, then `make test`.
- `make check` verifies `jq` and Safari access.
- `make compile` compiles AppleScript files and shellchecks shell wrappers when `shellcheck` is available.
- `make test` runs the dictionary contract and smoke checks.

## Public vs internal

- Public: `scripts/commands/tab/*.sh`, `window/*.sh`, `url/open.sh`, `javascript/run.sh`, `reading-list/add.sh`, `bookmarks/show.sh`, `search/web.sh`
- Internal: `scripts/applescripts/**`

## Safety rules

- Read commands are safe by default.
- Write actions are explicit: `url/open.sh`, `javascript/run.sh`, `reading-list/add.sh`, `tab/close.sh`, `window/close.sh`, `tab/email-contents.sh`, `bookmarks/show.sh`, `search/web.sh`.
- Treat Safari browsing data as real user data.

## Common pitfalls

- Safari automation may require Automation permission and Full Disk Access.
- JavaScript execution requires Safari's "Allow JavaScript from Apple Events" setting.
- `jq` is required for the public shell wrappers.
- CI validates the public shell command surface, not direct AppleScript entrypoints.
