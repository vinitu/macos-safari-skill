-- Bring a window to the front. argv: <window-index>
-- Returns JSON: {"success":true,"window":N}
on run argv
	if (count of argv) is 0 then
		return "{\"success\":false,\"error\":\"missing window index\"}"
	end if

	set wi to (item 1 of argv) as integer

	tell application "Safari"
		if wi > (count of windows) then
			return "{\"success\":false,\"error\":\"window " & wi & " not found\"}"
		end if
		set index of window wi to 1
		activate
	end tell

	return "{\"success\":true,\"window\":" & wi & "}"
end run
