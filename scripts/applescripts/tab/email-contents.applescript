-- Email contents of current tab.
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "No window"
		end if
		email contents of front document
	end tell
	return "opened"
end run
