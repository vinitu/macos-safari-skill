---
name: macos-safari-skill
description: Use this skill when you need to work with Safari on macOS through scripts/commands.
---

# macOS Safari

Use this skill when the task is about Safari on macOS.

## Main Rule

Use only `scripts/commands`.
Do not call `scripts/applescripts` directly.

## Requirements

- macOS with Safari.app
- Automation permissions for the terminal.
- "Allow JavaScript from Apple Events" enabled in Safari (Develop menu).

## Public Interface

Run commands from `scripts/commands`:

- `scripts/commands/tab/*`
- `scripts/commands/window/*`
- `scripts/commands/url/*`
- `scripts/commands/javascript/*`
- `scripts/commands/reading-list/*`
- `scripts/commands/bookmarks/*`
- `scripts/commands/search/*`

## Output Rules

- Commands return JSON by default.
- Error responses: `{"success":false,"error":"..."}` via `common.sh` helpers.

## Commands

### Tabs

List all tabs in front window as JSON array:

```bash
scripts/commands/tab/list.sh
```

Find a tab by URL or title pattern across all windows:

```bash
scripts/commands/tab/find.sh <pattern> [--focus] [--all]
```

Switch to a specific tab (brings Safari to front):

```bash
scripts/commands/tab/focus.sh <window> <tab>
```

Move current tab to another window:

```bash
scripts/commands/tab/move.sh --to <window> [--window N] [--tab N]
```

Reload a tab:

```bash
scripts/commands/tab/reload.sh [--window N] [--tab N]
```

Duplicate a tab (opens its URL in a new tab):

```bash
scripts/commands/tab/duplicate.sh [--window N] [--tab N]
```

Take a screenshot of a tab; saves to `/tmp/safari-screenshot.png` by default:

```bash
scripts/commands/tab/screenshot.sh [--output path] [--window N] [--tab N]
```

Get URL of a tab:

```bash
scripts/commands/tab/url.sh [--window N] [--tab N]
```

Get title of a tab:

```bash
scripts/commands/tab/title.sh [--window N] [--tab N]
```

Get page source of a tab:

```bash
scripts/commands/tab/source.sh [--window N] [--tab N]
```

Get email-friendly contents of a tab:

```bash
scripts/commands/tab/email-contents.sh [--window N] [--tab N]
```

Count tabs in a window — returns `{"count":N}`:

```bash
scripts/commands/tab/count.sh [window-index]
```

Close a tab:

```bash
scripts/commands/tab/close.sh [--window N] [--tab N]
```

### Windows

List all windows as JSON array (includes tabs_count per window):

```bash
scripts/commands/window/list.sh
```

Open a new empty window:

```bash
scripts/commands/window/new.sh
```

Bring a window to front:

```bash
scripts/commands/window/focus.sh <window>
```

List all tabs for a specific window (or all windows if omitted):

```bash
scripts/commands/window/tabs.sh [window]
```

Count open windows — returns `{"count":N}`:

```bash
scripts/commands/window/count.sh
```

Close a window:

```bash
scripts/commands/window/close.sh [window-index]
```

### URLs and Navigation

Open URL (target: current-tab, new-tab, new-window):

```bash
scripts/commands/url/open.sh "https://example.com" [target]
```

### JavaScript

Run JavaScript in current tab:

```bash
scripts/commands/javascript/run.sh "document.body.innerText"
```

Run JavaScript in a specific window/tab:

```bash
scripts/commands/javascript/run.sh "document.title" --window 2 --tab 3
```

### Bookmarks and Reading List

Open Safari's Bookmarks view — returns `{"success":true}`:

```bash
scripts/commands/bookmarks/show.sh
```

Add a URL to Reading List — returns `{"success":true,"url":"..."}`:

```bash
scripts/commands/reading-list/add.sh <url>
```

### Search

Search the web using Safari's default engine — returns `{"success":true,"query":"..."}`:

```bash
scripts/commands/search/the-web.sh "query"
```

## JSON Contract

Tab object:

- `index`
- `name`
- `url`

Window object:

- `index`
- `name`
- `tabs_count`

Find result:

- `window`
- `tab`
- `name`
- `url`

Window tabs:

- `window`
- `tabs` (array of tab objects)

Scalar envelopes:

- `count`: `{"count": N}`
- `success/failure`: `{"success": true/false, "error": "..."}`

## Safety Boundaries

- Write actions (close, open, run JS) must be explicit.
- Internal AppleScript files are not public API.
- Never execute JavaScript from untrusted sources.
- Protect user privacy: do not log or store browsing history or session data.
