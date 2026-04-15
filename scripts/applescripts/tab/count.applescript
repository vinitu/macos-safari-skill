-- Count tabs in a window. argv: [window-index]
-- Default: front window
-- Returns JSON: {"count":N}
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "{\"count\":0}"
		end if

		if (count of argv) ≥ 1 then
			set wi to (item 1 of argv) as integer
			if wi > (count of windows) then
				return "{\"success\":false,\"error\":\"window " & wi & " not found\"}"
			end if
			return "{\"count\":" & (count of tabs of window wi) & "}"
		end if

		return "{\"count\":" & (count of tabs of front window) & "}"
	end tell
end run
