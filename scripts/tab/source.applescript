-- Get HTML source of current tab.
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return ""
		end if
		return source of current tab of front window
	end tell
end run
