-- Count Safari windows.
on run argv
	tell application "Safari"
		return (count of windows) as text
	end tell
end run
