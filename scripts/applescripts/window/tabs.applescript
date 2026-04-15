-- List all tabs for a specific window (or all windows if no argument).
-- argv: [window_index]
-- Returns JSON array of tab objects.
on run argv
	tell application "Safari"
		set winCount to count of windows

		if (count of argv) > 0 then
			set wi to (item 1 of argv) as integer
			if wi > winCount then
				return "{\"success\":false,\"error\":\"window " & wi & " not found\"}"
			end if
			return my tabsForWindow(wi)
		end if

		-- All windows
		set output to "["
		repeat with wi from 1 to winCount
			if wi > 1 then set output to output & ","
			set output to output & my tabsForWindow(wi)
		end repeat
		set output to output & "]"
		return output
	end tell
end run

on tabsForWindow(wi)
	tell application "Safari"
		set tabCount to count of tabs of window wi
		set output to "{\"window\":" & wi & ",\"tabs\":["
		repeat with ti from 1 to tabCount
			set t to tab ti of window wi
			set tabURL to URL of t
			set tabName to name of t
			set safeName to my jsonEscape(tabName)
			set safeURL to my jsonEscape(tabURL)
			if ti > 1 then set output to output & ","
			set output to output & "{\"index\":" & ti & ",\"name\":\"" & safeName & "\",\"url\":\"" & safeURL & "\"}"
		end repeat
		set output to output & "]}"
		return output
	end tell
end tabsForWindow

on jsonEscape(valueText)
	set escapedText to valueText as text
	set escapedText to my replaceText("\\", "\\\\", escapedText)
	set escapedText to my replaceText("\"", "\\\"", escapedText)
	set escapedText to my replaceText(return, "\\r", escapedText)
	set escapedText to my replaceText(linefeed, "\\n", escapedText)
	return escapedText
end jsonEscape

on replaceText(findText, replaceWith, sourceText)
	set AppleScript's text item delimiters to findText
	set textItems to every text item of sourceText
	set AppleScript's text item delimiters to replaceWith
	set replacedText to textItems as text
	set AppleScript's text item delimiters to ""
	return replacedText
end replaceText
