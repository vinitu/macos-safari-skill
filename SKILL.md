---
name: macos-safari
description: Use this skill when you need to automate Safari on macOS through scripts/commands. Supports tab and window inspection, URL opening, JavaScript execution, bookmarks display, Reading List updates, and web search.
---

# macOS Safari

Use this skill when the task is about Safari on macOS.

## Overview

- Public interface: `scripts/commands`
- Internal backend: `scripts/applescripts`
- Output: JSON by default

## Main Rule

Use only `scripts/commands`.
Do not call `scripts/applescripts` directly.

## Requirements

- macOS with Safari installed
- `jq`
- Automation permission for your terminal
- "Allow JavaScript from Apple Events" enabled for `javascript/run.sh`

## Public Interface

- `scripts/commands/tab/*`
- `scripts/commands/window/*`
- `scripts/commands/url/open.sh`
- `scripts/commands/javascript/run.sh`
- `scripts/commands/reading-list/add.sh`
- `scripts/commands/bookmarks/show.sh`
- `scripts/commands/search/web.sh`

## Output Rules

- Commands return JSON by default.
- Failures return `{"success":false,"error":"..."}`.
- Write actions return explicit confirmation objects inside `data`.

## Commands

### Tab

```bash
scripts/commands/tab/list.sh
scripts/commands/tab/count.sh
scripts/commands/tab/url.sh
scripts/commands/tab/title.sh 2
scripts/commands/tab/source.sh
scripts/commands/tab/close.sh current
scripts/commands/tab/email-contents.sh
```

### Window

```bash
scripts/commands/window/list.sh
scripts/commands/window/count.sh
scripts/commands/window/close.sh
```

### URL, JavaScript, and Safari actions

```bash
scripts/commands/url/open.sh "https://example.com" new-tab
scripts/commands/javascript/run.sh 'document.title'
scripts/commands/reading-list/add.sh "https://example.com"
scripts/commands/bookmarks/show.sh
scripts/commands/search/web.sh "OpenAI docs"
```

## JSON Contract

- tab list: `{"success":true,"data":{"tabs":[{"index":1,"title":"...","url":"..."}]}}`
- window list: `{"success":true,"data":{"windows":[{"index":1,"name":"..."}]}}`
- count: `{"success":true,"data":{"count":2}}`
- value: `{"success":true,"data":{"url":"..."}}`, `{"title":"..."}`, `{"source":"..."}`
- action: `{"success":true,"data":{"opened":true}}`, `{"closed":true}`, `{"searched":true}`

## Safety Boundaries

- Write actions must be explicit and require user approval: `url/open.sh`, `javascript/run.sh`, `reading-list/add.sh`, `tab/close.sh`, `window/close.sh`, `tab/email-contents.sh`, `bookmarks/show.sh`, `search/web.sh`.
- Internal AppleScript files are not public API.
