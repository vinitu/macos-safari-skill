-- Open Safari's Bookmarks sidebar/view via keyboard shortcut (Cmd+Alt+1).
-- Returns JSON: {"success":true}
on run argv
	tell application "Safari"
		activate
		delay 0.3
	end tell
	tell application "System Events"
		tell process "Safari"
			keystroke "1" using {command down, option down}
		end tell
	end tell
	return "{\"success\":true}"
end run
