# macOS Safari Skill

This repo stores a skill for automating Safari on macOS using AppleScript.

## Installation

Install with `skills.sh`:

```bash
skills.sh add vinitu/macos-safari-skill
```

If you use the npm installer instead:

```bash
npx skills add vinitu/macos-safari-skill
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

```bash
# Open a URL in a new tab
osascript -e 'tell application "Safari" to tell front window to set current tab to (make new tab with properties {URL:"https://example.com"})'

# Get the current page URL
osascript -e 'tell application "Safari" to return URL of current tab of front window'

# Get the current page title
osascript -e 'tell application "Safari" to return name of current tab of front window'

# Execute JavaScript in the current tab
osascript -e 'tell application "Safari" to do JavaScript "document.body.innerText" in current tab of front window'

# Search browsing history
sqlite3 ~/Library/Safari/History.db "SELECT v.title, i.url FROM history_visits v JOIN history_items i ON v.history_item = i.id ORDER BY v.visit_time DESC LIMIT 10;"
```

For the full command set and examples, see `SKILL.md`.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| JavaScript returns empty | Page may not be fully loaded; add `delay` before reading |
| Can't read History.db | Grant Full Disk Access to terminal in System Settings |
| Safari not responding | Ensure Safari is running; try `tell application "Safari" to activate` first |
