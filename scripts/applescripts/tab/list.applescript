-- List tabs of the front window. One line per tab: name TAB URL
tell application "Safari"
	if (count of windows) is 0 then
		return ""
	end if
	set tabList to every tab of front window
	set output to ""
	repeat with t in tabList
		set output to output & (name of t) & tab & (URL of t) & linefeed
	end repeat
	return output
end tell
