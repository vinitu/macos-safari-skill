# macOS Safari Skill

This repo stores a skill for automating Safari on macOS using AppleScript.

## Installation

```bash
npx skills add vinitu/macos-safari-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-safari-skill
```

## Scope

- Open URLs in new tabs or windows.
- Read page content, titles, and source HTML.
- Manage tabs and windows (list, switch, close).
- Execute JavaScript in the current page.
- Search browsing history and bookmarks.

## Prerequisites

- macOS with Safari installed
- Automation permission granted to your terminal
- Full Disk Access for reading history and bookmarks databases
- "Allow JavaScript from Apple Events" enabled in Safari (Develop menu)

## How To Use

From the skill directory (or path where scripts are installed):

```bash
# Open URL in new tab (or current-tab, new-window)
osascript scripts/url/open.applescript "https://example.com" new-tab
# Get URL of current tab
osascript scripts/tab/url.applescript
# Get title of current tab
osascript scripts/tab/title.applescript
# Run JavaScript in current tab; returns result
osascript scripts/javascript/run.applescript "document.body.innerText"
```

Browsing history is read via SQLite (Full Disk Access required):

```bash
# Last 10 visited pages (title, url)
sqlite3 ~/Library/Safari/History.db "SELECT v.title, i.url FROM history_visits v JOIN history_items i ON v.history_item = i.id ORDER BY v.visit_time DESC LIMIT 10;"
```

For the full command set and examples, see `SKILL.md` and scripts under `scripts/`.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| JavaScript returns empty | Page may not be fully loaded; add `delay` before reading |
| Can't read History.db | Grant Full Disk Access to terminal in System Settings |
| Safari not responding | Ensure Safari is running; try `tell application "Safari" to activate` first |
