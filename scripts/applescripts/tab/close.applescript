-- Close tab. argv: [index] or "current"
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "No window"
		end if
		if (count of argv) is 0 or (item 1 of argv) is "current" then
			close current tab of front window
		else
			set tabIndex to (item 1 of argv) as integer
			close tab tabIndex of front window
		end if
	end tell
	return "closed"
end run
