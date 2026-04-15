-- Find tabs by URL or title pattern across all windows.
-- argv: pattern [--focus] [--all]
-- Default: returns first match as JSON object
-- --all: returns JSON array of all matches
-- --focus: switches Safari to the first match
on run argv
	if (count of argv) is 0 then
		return "{\"success\":false,\"error\":\"missing pattern\"}"
	end if

	set pattern to item 1 of argv
	set shouldFocus to false
	set returnAll to false

	set i to 2
	repeat while i ≤ (count of argv)
		set arg to item i of argv
		if arg is "--focus" then
			set shouldFocus to true
		else if arg is "--all" then
			set returnAll to true
		end if
		set i to i + 1
	end repeat

	set matches to {}
	set firstWin to 0
	set firstTab to 0

	tell application "Safari"
		set winCount to count of windows
		repeat with wi from 1 to winCount
			set tabCount to count of tabs of window wi
			repeat with ti from 1 to tabCount
				set t to tab ti of window wi
				set tabURL to URL of t
				set tabName to name of t
				if tabURL contains pattern or tabName contains pattern then
					set safeName to my jsonEscape(tabName)
					set safeURL to my jsonEscape(tabURL)
					set entry to "{\"window\":" & wi & ",\"tab\":" & ti & ",\"name\":\"" & safeName & "\",\"url\":\"" & safeURL & "\"}"
					set end of matches to entry
					if firstWin is 0 then
						set firstWin to wi
						set firstTab to ti
					end if
				end if
			end repeat
		end repeat

		if shouldFocus and firstWin > 0 then
			set current tab of window firstWin to tab firstTab of window firstWin
			activate
		end if
	end tell

	if (count of matches) is 0 then
		return "{\"success\":false,\"error\":\"no tab found matching: " & my jsonEscape(pattern) & "\"}"
	end if

	if returnAll then
		set output to "["
		repeat with idx from 1 to (count of matches)
			if idx > 1 then set output to output & ","
			set output to output & item idx of matches
		end repeat
		return output & "]"
	end if

	return item 1 of matches
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
