-- Switch to a specific tab by window and tab index.
-- argv: window_index tab_index
on run argv
	if (count of argv) < 2 then
		return "{\"success\":false,\"error\":\"usage: focus.sh <window> <tab>\"}"
	end if

	set wi to (item 1 of argv) as integer
	set ti to (item 2 of argv) as integer

	tell application "Safari"
		if wi > (count of windows) then
			return "{\"success\":false,\"error\":\"window " & wi & " not found\"}"
		end if
		if ti > (count of tabs of window wi) then
			return "{\"success\":false,\"error\":\"tab " & ti & " not found in window " & wi & "\"}"
		end if
		set current tab of window wi to tab ti of window wi
		activate
	end tell

	return "{\"success\":true,\"window\":" & wi & ",\"tab\":" & ti & "}"
end run
