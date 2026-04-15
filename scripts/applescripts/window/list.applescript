-- List all windows as JSON array.
-- Each object: {"index":N,"name":"...","tabs_count":N}
on run argv
	tell application "Safari"
		set wins to every window
		set winCount to count of wins
		set output to "["
		repeat with wi from 1 to winCount
			set w to item wi of wins
			set tabCount to count of tabs of w
			set winName to name of w
			set safeName to do shell script "echo " & quoted form of winName & " | sed 's/\"/\\\\\"/g'"
			if wi > 1 then set output to output & ","
			set output to output & "{\"index\":" & wi & ",\"name\":\"" & safeName & "\",\"tabs_count\":" & tabCount & "}"
		end repeat
		set output to output & "]"
		return output
	end tell
end run
