-- Get HTML source of a tab. argv: [--window N] [--tab N]
-- Default: current tab of front window
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return ""
		end if

		set targetWindow to 0
		set targetTab to 0

		set i to 1
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

		if targetWindow > 0 then
			set w to window targetWindow
		else
			set w to front window
		end if

		if targetTab > 0 then
			return source of tab targetTab of w
		end if
		return source of current tab of w
	end tell
end run
