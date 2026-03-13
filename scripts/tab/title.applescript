-- Get title of current tab. argv: [tabIndex]
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return ""
		end if
		if (count of argv) ≥ 1 then
			return name of tab (item 1 of argv) as integer of front window
		end if
		return name of current tab of front window
	end tell
end run
