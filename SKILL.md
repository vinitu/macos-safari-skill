---
name: macos-safari-skill
description: Use this skill when you need to work with Safari on macOS through scripts/commands.
---

# macOS Safari

Use this skill when the task is about Safari on macOS.

## Overview
- Public interface: `scripts/commands`
- Internal backend: `scripts/applescripts`
- Output: JSON or text by default

## Main Rule
Use only `scripts/commands`.
Do not call `scripts/applescripts` directly.

## Requirements
- macOS with Safari.app
- Automation permissions for the terminal.
- "Allow JavaScript from Apple Events" enabled in Safari (Develop menu).

## Public Interface
- `scripts/commands/tab/*`
- `scripts/commands/window/*`
- `scripts/commands/url/*`
- `scripts/commands/javascript/*`
- `scripts/commands/reading-list/*`
- `scripts/commands/bookmarks/*`
- `scripts/commands/search/*`

## Output Rules
- Commands return JSON or plain text by default.
- Tab and window list commands return JSON objects.
- Error responses are returned as JSON: `{"success":false,"error":"..."}` via `common.sh` helpers.

## Commands

### Tabs
```bash
# List all tabs in front window
scripts/commands/tab/list.sh

# Get URL of current tab (or specific tab index)
scripts/commands/tab/url.sh [index]

# Get title of current tab (or specific tab index)
scripts/commands/tab/title.sh [index]

# Get page source of current tab
scripts/commands/tab/source.sh [index]

# Get email-friendly contents of current tab
scripts/commands/tab/email-contents.sh [index]

# Count tabs in front window
scripts/commands/tab/count.sh

# Close current tab (or specific tab index)
scripts/commands/tab/close.sh [index]
```

### Windows
```bash
# List all windows
scripts/commands/window/list.sh

# Count open windows
scripts/commands/window/count.sh

# Close front window (or specific window index)
scripts/commands/window/close.sh [index]
```

### URLs and Navigation
```bash
# Open URL (target: current-tab, new-tab, new-window)
scripts/commands/url/open.sh "https://example.com" [target]
```

### JavaScript
```bash
# Run JavaScript in current tab
scripts/commands/javascript/run.sh "document.body.innerText"
```

### Bookmarks and Reading List
```bash
# Add current page to reading list
scripts/commands/reading-list/add.sh

# Show bookmarks
scripts/commands/bookmarks/show.sh
```

### Search
```bash
# Search the web using default engine
scripts/commands/search/the-web.sh "query"
```

## JSON Contract
- Tab object: `{"index":1,"name":"...","url":"..."}`
- Window object: `{"index":1,"name":"...","tabs_count":N}`
- Success/Failure: `{"success":true/false,"error":"..."}`

## Safety Boundaries
- Write actions (close, open, run JS) must be explicit.
- Internal AppleScript files are not public API.
- Never execute JavaScript from untrusted sources.
- Protect user privacy: do not log or store browsing history or session data.
