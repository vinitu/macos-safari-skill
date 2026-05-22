# macOS Safari Skill

This repo stores an AI agent skill for Apple Safari.app on macOS.

The public interface is `scripts/commands`.
`scripts/applescripts` stores internal AppleScript backends and dictionary-aligned coverage.

## Installation

```bash
npx skills add vinitu/macos-safari-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-safari-skill
```

## Prerequisites

- macOS with Safari installed
- Automation permission granted to your terminal app
- "Allow JavaScript from Apple Events" enabled in Safari (Develop menu)

## Public Interface

Run skill actions with:

```bash
scripts/commands/<entity>/<action>.sh [args...]
```

Output rules:

- Commands return JSON by default unless noted otherwise.
- `--json`, `--plain`, and `--format=plain|json` are not supported.

## Backend Map

- `scripts/commands/tab/*` → AppleScript in `scripts/applescripts/tab/*`
- `scripts/commands/window/*` → AppleScript in `scripts/applescripts/window/*`
- `scripts/commands/url/*` → AppleScript in `scripts/applescripts/url/*`
- `scripts/commands/javascript/*` → AppleScript in `scripts/applescripts/javascript/*`
- `scripts/commands/reading-list/*` → AppleScript in `scripts/applescripts/reading-list/*`
- `scripts/commands/bookmarks/*` → AppleScript in `scripts/applescripts/bookmarks/*`
- `scripts/commands/search/*` → AppleScript in `scripts/applescripts/search/*`

`scripts/applescripts` is internal. Do not call it directly from the skill instructions.

## Command Surface

Tab:

- `scripts/commands/tab/list.sh`
- `scripts/commands/tab/find.sh`
- `scripts/commands/tab/focus.sh`
- `scripts/commands/tab/move.sh`
- `scripts/commands/tab/reload.sh`
- `scripts/commands/tab/duplicate.sh`
- `scripts/commands/tab/screenshot.sh`
- `scripts/commands/tab/url.sh`
- `scripts/commands/tab/title.sh`
- `scripts/commands/tab/source.sh`
- `scripts/commands/tab/email-contents.sh`
- `scripts/commands/tab/count.sh`
- `scripts/commands/tab/close.sh`

Window:

- `scripts/commands/window/list.sh`
- `scripts/commands/window/new.sh`
- `scripts/commands/window/focus.sh`
- `scripts/commands/window/tabs.sh`
- `scripts/commands/window/count.sh`
- `scripts/commands/window/close.sh`

URL and navigation:

- `scripts/commands/url/open.sh`

JavaScript:

- `scripts/commands/javascript/run.sh`

Bookmarks and Reading List:

- `scripts/commands/bookmarks/show.sh`
- `scripts/commands/reading-list/add.sh`

Search:

- `scripts/commands/search/the-web.sh`

## JSON Contract

- Tab object: `{"index":N,"name":"...","url":"..."}`
- Window object: `{"index":N,"name":"...","tabs_count":N}`
- Find result: `{"window":N,"tab":N,"name":"...","url":"..."}`
- Window tabs: `{"window":N,"tabs":[{"index":N,"name":"...","url":"..."}]}`
- Count: `{"count":N}`
- Success/Failure: `{"success":true/false,"error":"..."}`

## Validation

```bash
make compile
make test
```

`make test` runs live checks against Safari.app and expects Safari to be available. `make check` verifies Safari is accessible before running smoke tests.

## Known Limits

- Safari must be running for most commands to work.
- TCC permissions (Automation) must be granted to the terminal or parent process.
- Private windows may have different behavior or restricted access.
- Reading Safari's History.db requires Full Disk Access (not currently implemented).
