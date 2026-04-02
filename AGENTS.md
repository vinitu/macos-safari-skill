# macOS Safari Skill Agents Guide

Use this skill when the task is about Safari on macOS.
This repository provides a skill for automating macOS Safari via AppleScript.
It exposes a stable public interface via shell scripts that return JSON or plain text.

## Source of Truth
- `SKILL.md` is the primary contract for agent interactions.
- `scripts/commands/` is the only public command surface.
- `scripts/applescripts/` is the internal implementation.

## Repository Layout
- `AGENTS.md`: This guide for AI agents.
- `README.md`: Human-facing overview and installation.
- `SKILL.md`: Detailed command contract and examples.
- `Makefile`: Entrypoints for validation (`compile`, `test`, `check`).
- `scripts/commands/`: Public shell wrappers (JSON/text output).
- `scripts/applescripts/`: Internal AppleScript backends.
- `tests/`: Automated validation and contract checks.
- `.github/workflows/`: CI pipelines for PRs and main branch.

## Working Rules
- Always use `scripts/commands/` to interact with Safari.
- Never call `scripts/applescripts/` directly.
- Read operations are safe; write operations (close, open, run JS) must be explicit.
- Follow the existing naming pattern when adding new commands.
- Ensure all public commands are documented in `SKILL.md`.

## Validation
- `make check`: Verify Safari is available and responding.
- `make compile`: Syntax check for all AppleScript and shell scripts.
- `make test`: Run all automated tests (smoke tests and dictionary contract).

## Common Pitfalls
- Safari must be running for most commands to work.
- TCC permissions (Automation) must be granted to the terminal or parent process.
- Private windows may have different behavior or restricted access.

## Safety Rules
- Never open URLs or execute JavaScript without explicit user approval.
- Protect user privacy: do not log or store browsing history or session data.
- Write actions (close, open, run JS) must be explicit.
- Internal AppleScript files are not public API.
