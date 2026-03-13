---
name: macos-safari
description: Automate Safari on macOS using AppleScript. Use for opening URLs, reading page content, managing tabs/windows, executing JavaScript, and searching bookmarks/history. Triggers on queries about browsing, web pages, Safari tabs, bookmarks, or web automation.
---

# macOS Safari Automation

Control Safari on macOS using AppleScript via the `osascript` command.

## Prerequisites

- macOS with Safari installed
- Automation permission granted to your terminal (System Settings > Privacy & Security > Automation)

## Opening URLs

### Open a URL in the current tab
```bash
osascript -e 'tell application "Safari" to set URL of current tab of front window to "https://example.com"'
```

### Open a URL in a new tab
```bash
osascript -e 'tell application "Safari" to tell front window to set current tab to (make new tab with properties {URL:"https://example.com"})'
```

### Open a URL in a new window
```bash
osascript -e 'tell application "Safari" to make new document with properties {URL:"https://example.com"}'
```

### Open Safari and bring to front
```bash
osascript -e 'tell application "Safari" to activate'
```

## Reading Page Content

### Get the current page URL
```bash
osascript -e 'tell application "Safari" to return URL of current tab of front window'
```

### Get the current page title
```bash
osascript -e 'tell application "Safari" to return name of current tab of front window'
```

### Get page source (HTML)
```bash
osascript -e 'tell application "Safari" to return source of current tab of front window'
```

### Get visible text content via JavaScript
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.body.innerText" in current tab of front window'
```

### Get a specific element's text
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.querySelector(\"h1\").innerText" in current tab of front window'
```

## Managing Tabs

### List all tabs in the front window
```bash
osascript -e '
tell application "Safari"
    set tabList to ""
    set tabIndex to 1
    repeat with t in tabs of front window
        set tabList to tabList & tabIndex & ". [" & name of t & "] " & URL of t & linefeed
        set tabIndex to tabIndex + 1
    end repeat
    return tabList
end tell'
```

### Get the number of open tabs
```bash
osascript -e 'tell application "Safari" to return count of tabs of front window'
```

### Switch to a specific tab (by index, 1-based)
```bash
osascript -e 'tell application "Safari" to set current tab of front window to tab 3 of front window'
```

### Close the current tab
```bash
osascript -e 'tell application "Safari" to close current tab of front window'
```

### Close a specific tab by index
```bash
osascript -e 'tell application "Safari" to close tab 2 of front window'
```

## Managing Windows

### List all windows with their current tab info
```bash
osascript -e '
tell application "Safari"
    set winList to ""
    set winIndex to 1
    repeat with w in windows
        set winList to winList & winIndex & ". " & name of current tab of w & " — " & URL of current tab of w & linefeed
        set winIndex to winIndex + 1
    end repeat
    return winList
end tell'
```

### Get the number of open windows
```bash
osascript -e 'tell application "Safari" to return count of windows'
```

### Close the front window
```bash
osascript -e 'tell application "Safari" to close front window'
```

## Executing JavaScript

### Run arbitrary JavaScript in the current tab
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.title" in current tab of front window'
```

### Click a button or link
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.querySelector(\"button.submit\").click()" in current tab of front window'
```

### Fill in a form field
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.querySelector(\"input[name=email]\").value = \"user@example.com\"" in current tab of front window'
```

### Scroll to the bottom of the page
```bash
osascript -e 'tell application "Safari" to do JavaScript "window.scrollTo(0, document.body.scrollHeight)" in current tab of front window'
```

### Wait for an element (poll with JavaScript)
```bash
osascript -e '
tell application "Safari"
    repeat 30 times
        set result to do JavaScript "document.querySelector(\".loaded\") !== null" in current tab of front window
        if result is "true" then exit repeat
        delay 1
    end repeat
end tell'
```

## Bookmarks and History

### Search bookmarks via plist conversion
```bash
# Bookmarks are stored in a plist; convert and search:
plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist | grep -i "search term"
```

### Search browsing history via SQLite
```bash
sqlite3 ~/Library/Safari/History.db "SELECT v.title, i.url, datetime(v.visit_time + 978307200, 'unixepoch', 'localtime') as visit_date FROM history_visits v JOIN history_items i ON v.history_item = i.id ORDER BY v.visit_time DESC LIMIT 20;"
```

### Search history for a specific domain
```bash
sqlite3 ~/Library/Safari/History.db "SELECT v.title, i.url, datetime(v.visit_time + 978307200, 'unixepoch', 'localtime') as visit_date FROM history_visits v JOIN history_items i ON v.history_item = i.id WHERE i.url LIKE '%example.com%' ORDER BY v.visit_time DESC LIMIT 20;"
```

### Search history by title
```bash
sqlite3 ~/Library/Safari/History.db "SELECT v.title, i.url, datetime(v.visit_time + 978307200, 'unixepoch', 'localtime') as visit_date FROM history_visits v JOIN history_items i ON v.history_item = i.id WHERE v.title LIKE '%search term%' ORDER BY v.visit_time DESC LIMIT 20;"
```

## Common Use Cases

### Open a page and extract its title
```bash
osascript -e '
tell application "Safari"
    make new document with properties {URL:"https://example.com"}
    delay 3
    return name of current tab of front window
end tell'
```

### Save current page text to a file
```bash
osascript -e 'tell application "Safari" to do JavaScript "document.body.innerText" in current tab of front window' > /tmp/page-content.txt
```

### Get all links on the current page
```bash
osascript -e 'tell application "Safari" to do JavaScript "Array.from(document.querySelectorAll(\"a[href]\")).map(a => a.href).join(\"\\n\")" in current tab of front window'
```

### Take a screenshot of the current page (via screencapture)
```bash
osascript -e 'tell application "Safari" to activate'
sleep 0.5
screencapture -w /tmp/safari-screenshot.png
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "not authorized" error | Grant Automation permission to terminal in System Settings |
| JavaScript returns empty | Page may not be fully loaded; add `delay` before reading |
| Can't read History.db | Grant Full Disk Access to terminal in System Settings |
| Bookmarks plist unreadable | Use `plutil -convert xml1` to convert to readable format |
| Safari not responding to AppleScript | Ensure Safari is running; try `tell application "Safari" to activate` first |

## Technical Notes

- AppleScript controls Safari through its scripting dictionary (no private APIs)
- `do JavaScript` requires the "Allow JavaScript from Apple Events" setting enabled in Safari (Develop menu > Allow JavaScript from Apple Events)
- History database uses Core Data timestamps (seconds since 2001-01-01)
- Full Disk Access is required for reading History.db and Bookmarks.plist directly
- Tab indices are 1-based in AppleScript
