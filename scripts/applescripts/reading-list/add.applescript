-- Add URL to Reading List. argv: url [previewText] [title]
-- Returns JSON: {"success":true,"url":"..."}
on run argv
	if (count of argv) < 1 then
		return "{\"success\":false,\"error\":\"missing url\"}"
	end if
	set urlStr to item 1 of argv
	set previewText to ""
	set titleText to ""
	if (count of argv) ≥ 2 then set previewText to item 2 of argv
	if (count of argv) ≥ 3 then set titleText to item 3 of argv

	tell application "Safari"
		add reading list item urlStr
	end tell

	set safeURL to do shell script "echo " & quoted form of urlStr & " | sed 's/\"/\\\\\"/g'"
	return "{\"success\":true,\"url\":\"" & safeURL & "\"}"
end run
