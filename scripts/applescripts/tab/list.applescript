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
			set safeName to do shell script "echo " & quoted form of tabName & " | sed 's/\"/\\\\\"/g'"
			set safeURL to do shell script "echo " & quoted form of tabURL & " | sed 's/\"/\\\\\"/g'"
			if ti > 1 then set output to output & ","
			set output to output & "{\"index\":" & ti & ",\"name\":\"" & safeName & "\",\"url\":\"" & safeURL & "\"}"
		end repeat
		return output & "]"
	end tell
end run
