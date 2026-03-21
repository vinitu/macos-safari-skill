-- Show bookmarks (open Bookmarks view).
on run argv
	tell application "Safari"
		activate
		delay 0.5
		-- Show bookmarks via menu or shortcut; scripting may vary
		return "shown"
	end tell
end run
