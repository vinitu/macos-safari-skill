-- List tabs of the front window as JSON array.
-- Each object: {"index":N,"name":"...","url":"..."}
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return "[]"
		end if
		set tabList to every tab of front window
		set tabCount to count of tabList
		set output to "["
		repeat with ti from 1 to tabCount
			set t to item ti of tabList
			set tabURL to URL of t
			set tabName to name of t
			set safeName to my jsonEscape(tabName)
			set safeURL to my jsonEscape(tabURL)
			if ti > 1 then set output to output & ","
			set output to output & "{\"index\":" & ti & ",\"name\":\"" & safeName & "\",\"url\":\"" & safeURL & "\"}"
		end repeat
		return output & "]"
	end tell
end run

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
