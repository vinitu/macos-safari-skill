-- Move a tab to another window.
-- argv: --to <window> [--window N] [--tab N]
-- Default source: current tab of front window
-- Returns JSON: {"success":true,"window":N,"tab":N}
on run argv
	if (count of argv) is 0 then
		return "{\"success\":false,\"error\":\"missing --to <window>\"}"
	end if

	set targetWin to 0
	set sourceWin to 0
	set sourceTab to 0

	set i to 1
	repeat while i ≤ (count of argv)
		set arg to item i of argv
		if arg is "--to" and i < (count of argv) then
			set targetWin to (item (i + 1) of argv) as integer
			set i to i + 2
		else if arg is "--window" and i < (count of argv) then
			set sourceWin to (item (i + 1) of argv) as integer
			set i to i + 2
		else if arg is "--tab" and i < (count of argv) then
			set sourceTab to (item (i + 1) of argv) as integer
			set i to i + 2
		else
			set i to i + 1
		end if
	end repeat

	if targetWin is 0 then
		return "{\"success\":false,\"error\":\"missing --to <window>\"}"
	end if

	tell application "Safari"
		set windowCount to count of windows
		if windowCount is 0 then
			return "{\"success\":false,\"error\":\"no windows open\"}"
		end if
		if targetWin > windowCount then
			return "{\"success\":false,\"error\":\"target window " & targetWin & " not found\"}"
		end if

		if sourceWin > 0 then
			if sourceWin > windowCount then
				return "{\"success\":false,\"error\":\"source window " & sourceWin & " not found\"}"
			end if
			set w to window sourceWin
		else
			set w to front window
			set sourceWin to index of w
		end if

		if sourceWin is targetWin then
			return "{\"success\":false,\"error\":\"source and target windows must be different\"}"
		end if

		if sourceTab > 0 then
			if sourceTab > (count of tabs of w) then
				return "{\"success\":false,\"error\":\"tab " & sourceTab & " not found in window " & sourceWin & "\"}"
			end if
			set tabURL to URL of tab sourceTab of w
			close tab sourceTab of w
		else
			set tabURL to URL of current tab of w
			close current tab of w
		end if

		tell window targetWin to make new tab with properties {URL:tabURL}
		set newTabIdx to count of tabs of window targetWin
		set index of window targetWin to 1
		set current tab of window targetWin to tab newTabIdx of window targetWin
		activate
	end tell

	return "{\"success\":true,\"window\":" & targetWin & ",\"tab\":" & newTabIdx & "}"
end run
