# macOS Safari Skill

AI agent skill for Safari automation on macOS.

The public interface is `scripts/commands`.
`scripts/applescripts` stores internal AppleScript backends.

## Installation

```bash
npx skills add vinitu/macos-safari-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-safari-skill
```

The installed global skill directory is usually `~/.agents/skills/macos-safari`.

Name mapping:

- Repository: `macos-safari-skill`
- Package source: `vinitu/macos-safari-skill`
- Installed directory: `macos-safari`

## Public Interface

Run public commands from the repo root:

- `scripts/commands/tab/list.sh`
- `scripts/commands/tab/count.sh`
- `scripts/commands/tab/url.sh`
- `scripts/commands/tab/title.sh`
- `scripts/commands/tab/source.sh`
- `scripts/commands/tab/close.sh`
- `scripts/commands/tab/email-contents.sh`
- `scripts/commands/window/list.sh`
- `scripts/commands/window/count.sh`
- `scripts/commands/window/close.sh`
- `scripts/commands/url/open.sh`
- `scripts/commands/javascript/run.sh`
- `scripts/commands/reading-list/add.sh`
- `scripts/commands/bookmarks/show.sh`
- `scripts/commands/search/web.sh`

All public commands return JSON.

## Dependencies

- macOS with Safari installed
- `jq`
- Automation permission granted to your terminal
- Full Disk Access for reading Safari history and bookmarks when needed
- "Allow JavaScript from Apple Events" enabled in Safari for `javascript/run.sh`

## Repo Layout

```text
macos-safari-skill/
├── AGENTS.md
├── README.md
├── SKILL.md
├── Makefile
├── .github/workflows/
│   ├── ci-pr.yml
│   └── ci-main.yml
├── scripts/
│   ├── commands/
│   │   ├── bookmarks/show.sh
│   │   ├── javascript/run.sh
│   │   ├── reading-list/add.sh
│   │   ├── search/web.sh
│   │   ├── tab/*.sh
│   │   ├── url/open.sh
│   │   └── window/*.sh
│   └── applescripts/
│       ├── bookmarks/show.applescript
│       ├── javascript/run.applescript
│       ├── reading-list/add.applescript
│       ├── search/web.applescript
│       ├── tab/*.applescript
│       ├── url/open.applescript
│       └── window/*.applescript
└── tests/
    ├── dictionary_contract.sh
    └── smoke_safari.sh
```

## Examples

```bash
scripts/commands/tab/list.sh
scripts/commands/tab/count.sh
scripts/commands/tab/url.sh
scripts/commands/tab/title.sh 2
scripts/commands/window/list.sh
scripts/commands/javascript/run.sh 'document.title'
scripts/commands/url/open.sh 'https://example.com' new-tab
scripts/commands/reading-list/add.sh 'https://example.com'
```

## Output Contract

- `tab/list.sh` returns `{"success":true,"data":{"tabs":[{"index":1,"title":"...","url":"..."}]}}`
- `window/list.sh` returns `{"success":true,"data":{"windows":[{"index":1,"name":"..."}]}}`
- `tab/count.sh` and `window/count.sh` return a `count` integer.
- `tab/url.sh`, `tab/title.sh`, and `tab/source.sh` return one field object.
- Write actions return explicit confirmation objects such as `{"opened":true}` or `{"closed":true}` inside `data`.
- Failures return `{"success":false,"error":"..."}` with a non-zero exit status.

## Validation and Tests

```bash
make check
make compile
make test
```

CI workflows:

- `.github/workflows/ci-pr.yml` validates PRs, auto-merges approved branch flows, and prepares releases.
- `.github/workflows/ci-main.yml` validates `main`, creates a patch tag, and publishes a release.

## Known Limits

- The public interface is the shell wrapper layer, not direct AppleScript files.
- `javascript/run.sh` requires Safari's Apple Events JavaScript setting.
- Commands that open URLs, close tabs, close windows, or write to Reading List are explicit write actions.
- Browsing history and bookmarks access may need Full Disk Access.

## Unsupported Behaviour

- Direct use of `scripts/applescripts/**` as public API.
- Plain-text or custom output formats from public commands.
- Running write actions without explicit user approval.
