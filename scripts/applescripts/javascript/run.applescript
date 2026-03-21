-- Run JavaScript in current tab. argv: jsCode (one line) or read from stdin
on run argv
	if (count of argv) < 1 then
		return "Usage: run.applescript <javascript_code>"
	end if
	set jsCode to item 1 of argv

	tell application "Safari"
		if (count of windows) is 0 then
			return "No window"
		end if
		return do JavaScript jsCode in current tab of front window
	end tell
end run
