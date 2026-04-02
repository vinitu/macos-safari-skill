# macOS Safari Skill

This repository provides a skill for automating macOS Safari via AppleScript.
It exposes a stable public interface via shell scripts that return JSON or plain text.

## Installation

```bash
npx skills add vinitu/macos-safari-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-safari-skill
```

The package name is `vinitu/macos-safari-skill`. The skill is installed into the `macos-safari-skill` directory in your global skills folder.

## Prerequisites

- macOS with Safari installed
- Automation permission granted to your terminal
- "Allow JavaScript from Apple Events" enabled in Safari (Develop menu)

## Repository Layout
- `scripts/commands/`: Public shell wrappers (JSON/text output).
- `scripts/applescripts/`: Internal AppleScript backends (not for direct use).
- `tests/`: Automated validation and contract checks.
- `AGENTS.md`: Detailed guide for AI agents.
- `SKILL.md`: Detailed command contract and examples.

## How To Use

The public interface is located in `scripts/commands/`. All commands should be run from the repository root.

```bash
# Open URL in new tab
scripts/commands/url/open.sh "https://example.com" new-tab

# List all open tabs (JSON)
scripts/commands/tab/list.sh

# Get URL of current tab
scripts/commands/tab/url.sh

# Get title of current tab
scripts/commands/tab/title.sh

# Run JavaScript in current tab
scripts/commands/javascript/run.sh "document.body.innerText"
```

For the full command set and examples, see `SKILL.md`.

## Validation

After making changes, run the validation suite from the repo root:

```bash
make check    # Verify Safari is available and responding
make compile  # Syntax check all shell and AppleScript files
make test     # Run all automated tests (smoke tests and contract checks)
```

## Known Limits
- Safari must be running for most commands to work.
- TCC permissions (Automation) must be granted to the terminal or parent process.
- Private windows may have different behavior or restricted access.
- Reading Safari's History.db requires Full Disk Access (not currently implemented).
