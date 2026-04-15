-- Close a window. argv: [index]
-- Default: front window
-- Returns JSON: {"success":true}
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "{\"success\":false,\"error\":\"no windows open\"}"
		end if

		if (count of argv) ≥ 1 then
			set wi to (item 1 of argv) as integer
			if wi > (count of windows) then
				return "{\"success\":false,\"error\":\"window " & wi & " not found\"}"
			end if
			close window wi
		else
			close front window
		end if
	end tell

	return "{\"success\":true}"
end run
