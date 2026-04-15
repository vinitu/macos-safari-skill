-- Run JavaScript in a Safari tab.
-- argv: jsCode [--window N] [--tab N]
-- Default: current tab of front window
on run argv
	if (count of argv) < 1 then
		return "Usage: run.applescript <javascript_code> [--window N] [--tab N]"
	end if

	set jsCode to item 1 of argv
	set targetWindow to 0
	set targetTab to 0

	-- Parse optional --window and --tab flags
	set i to 2
	repeat while i ≤ (count of argv)
		set arg to item i of argv
		if arg is "--window" and i < (count of argv) then
			set targetWindow to (item (i + 1) of argv) as integer
			set i to i + 2
		else if arg is "--tab" and i < (count of argv) then
			set targetTab to (item (i + 1) of argv) as integer
			set i to i + 2
		else
			set i to i + 1
		end if
	end repeat

	tell application "Safari"
		if (count of windows) is 0 then
			return "{\"success\":false,\"error\":\"no windows open\"}"
		end if

		if targetWindow > 0 then
			if targetWindow > (count of windows) then
				return "{\"success\":false,\"error\":\"window " & targetWindow & " not found\"}"
			end if
			set w to window targetWindow
		else
			set w to front window
		end if

		if targetTab > 0 then
			if targetTab > (count of tabs of w) then
				return "{\"success\":false,\"error\":\"tab " & targetTab & " not found\"}"
			end if
			set t to tab targetTab of w
		else
			set t to current tab of w
		end if

		return do JavaScript jsCode in t
	end tell
end run
