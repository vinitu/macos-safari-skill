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

## Locating a Tab

When the user says "find the page with X" or "open tab with Y":

```bash
scripts/commands/tab/find.sh "substring"          # first match
scripts/commands/tab/find.sh "substring" --focus  # find and switch
scripts/commands/tab/find.sh "substring" --all    # all matches
```

## Reading Page Content

```bash
scripts/commands/javascript/run.sh "document.body.innerText"
scripts/commands/javascript/run.sh "document.body.innerText" --window 2 --tab 3
scripts/commands/tab/source.sh --window N --tab N
```

## Filling Forms

```bash
# Standard input
scripts/commands/javascript/run.sh \
  "var el=document.querySelector('input[name=x]');el.value='v';el.dispatchEvent(new Event('input',{bubbles:true}));"

# contenteditable rich-text (index = position among all editors on page)
scripts/commands/javascript/run.sh \
  "var el=document.querySelectorAll('[contenteditable]')[0];el.focus();el.innerHTML='<p>Text</p>';el.dispatchEvent(new Event('input',{bubbles:true}));"

# Custom button (e.g. rating scale)
scripts/commands/javascript/run.sh \
  "Array.from(document.querySelectorAll('button.scale-item')).find(b=>b.innerText.trim()==='5').click();"
```

## Navigating Between Windows and Tabs

```bash
scripts/commands/window/list.sh          # all windows with tab counts
scripts/commands/window/tabs.sh 2        # all tabs in window 2
scripts/commands/window/focus.sh 3       # bring window 3 to front
scripts/commands/tab/focus.sh 1 2        # switch to tab 2 in window 1
scripts/commands/tab/move.sh --to 2      # move current tab to window 2
```

## Common Patterns

```bash
# Open URL and verify
scripts/commands/url/open.sh "https://example.com" new-tab
sleep 2
scripts/commands/tab/url.sh

# Read background tab without switching
scripts/commands/javascript/run.sh "document.title" --window 2 --tab 4

# Reload after changes
scripts/commands/tab/reload.sh
```

## Common Pitfalls
- Safari must be running for most commands to work.
- TCC permissions (Automation) must be granted to the terminal or parent process.
- Private windows may have different behavior or restricted access.
- `tab/count.sh` and `window/count.sh` return `{"count":N}` — not a plain number.
- `tab/close.sh` and `window/close.sh` return `{"success":true}` — not plain text.

## Safety Rules
- Never open URLs or execute JavaScript without explicit user approval.
- Protect user privacy: do not log or store browsing history or session data.
- Write actions (close, open, run JS) must be explicit.
- Internal AppleScript files are not public API.
