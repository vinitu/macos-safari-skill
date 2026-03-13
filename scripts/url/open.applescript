-- Open URL. argv: url [current-tab|new-tab|new-window]
on run argv
	if (count of argv) < 1 then
		return "Usage: open.applescript <url> [current-tab|new-tab|new-window]"
	end if
	set urlStr to item 1 of argv
	set whereTo to "new-tab"
	if (count of argv) ≥ 2 then set whereTo to item 2 of argv

	tell application "Safari"
		if whereTo is "current-tab" then
			set URL of current tab of front window to urlStr
		else if whereTo is "new-window" then
			make new document with properties {URL:urlStr}
		else
			tell front window to make new tab with properties {URL:urlStr}
		end if
	end tell
	return "opened"
end run
