-- Count tabs in front window.
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "0"
		end if
		return (count of tabs of front window) as text
	end tell
end run
