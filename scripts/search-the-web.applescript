-- Search the web. argv: query [in tab]
on run argv
	if (count of argv) < 1 then
		return "Usage: search-the-web.applescript <query>"
	end if
	set query to item 1 of argv

	tell application "Safari"
		search the web for query
	end tell
	return "searched"
end run
