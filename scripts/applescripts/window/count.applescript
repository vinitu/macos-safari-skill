-- Count open Safari windows.
-- Returns JSON: {"count":N}
on run argv
	tell application "Safari"
		return "{\"count\":" & (count of windows) & "}"
	end tell
end run
