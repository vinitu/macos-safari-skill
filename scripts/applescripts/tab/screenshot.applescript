-- Take a screenshot of the current tab. argv: [--output path] [--window N] [--tab N]
-- Default output: /tmp/safari-screenshot.png
-- Returns JSON: {"success":true,"path":"..."}
on run argv
	set outputPath to "/tmp/safari-screenshot.png"
	set targetWindow to 0
	set targetTab to 0

	set i to 1
	repeat while i ≤ (count of argv)
		set arg to item i of argv
		if arg is "--output" and i < (count of argv) then
			set outputPath to item (i + 1) of argv
			set i to i + 2
		else if arg is "--window" and i < (count of argv) then
			set targetWindow to (item (i + 1) of argv) as integer
			set i to i + 2
		else if arg is "--tab" and i < (count of argv) then
			set targetTab to (item (i + 1) of argv) as integer
			set i to i + 2
		else
			set i to i + 1
		end if
	end repeat

	tell application "Safari"
		if (count of windows) is 0 then
			return "{\"success\":false,\"error\":\"no windows open\"}"
		end if

		if targetWindow > 0 then
			set w to window targetWindow
		else
			set w to front window
		end if

		if targetTab > 0 then
			set current tab of w to tab targetTab of w
		end if

		activate
		delay 0.3
	end tell

	do shell script "screencapture -l $(osascript -e 'tell application \"Safari\" to id of front window') " & quoted form of outputPath
	set safePath to do shell script "echo " & quoted form of outputPath & " | sed 's/\"/\\\\\"/g'"
	return "{\"success\":true,\"path\":\"" & safePath & "\"}"
end run
