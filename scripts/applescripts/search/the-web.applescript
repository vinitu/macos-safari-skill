-- Search the web. argv: query
-- Returns JSON: {"success":true,"query":"..."}
on run argv
	if (count of argv) < 1 then
		return "{\"success\":false,\"error\":\"missing query\"}"
	end if
	set query to item 1 of argv

	tell application "Safari"
		search the web for query
	end tell

	set safeQuery to do shell script "echo " & quoted form of query & " | sed 's/\"/\\\\\"/g'"
	return "{\"success\":true,\"query\":\"" & safeQuery & "\"}"
end run
