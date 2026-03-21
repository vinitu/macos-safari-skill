-- Close front window.
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "No window"
		end if
		close front window
	end tell
	return "closed"
end run
