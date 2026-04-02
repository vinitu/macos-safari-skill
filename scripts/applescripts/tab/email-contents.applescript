-- Email contents of current tab.
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "No window"
		end if
		tell current tab of front window
			get email contents
		end tell
	end tell
end run
