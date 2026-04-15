-- Open URL. argv: url [current-tab|new-tab|new-window]
-- Returns JSON: {"success":true,"url":"...","target":"..."}
on run argv
	if (count of argv) < 1 then
		return "{\"success\":false,\"error\":\"missing url\"}"
	end if
	set urlStr to item 1 of argv
	set whereTo to "new-tab"
	if (count of argv) ≥ 2 then set whereTo to item 2 of argv

	tell application "Safari"
		if whereTo is "current-tab" then
			set URL of current tab of front window to urlStr
		else if whereTo is "new-window" then
			make new document with properties {URL:urlStr}
		else
			tell front window to make new tab with properties {URL:urlStr}
		end if
	end tell

	set safeURL to do shell script "echo " & quoted form of urlStr & " | sed 's/\"/\\\\\"/g'"
	return "{\"success\":true,\"url\":\"" & safeURL & "\",\"target\":\"" & whereTo & "\"}"
end run
