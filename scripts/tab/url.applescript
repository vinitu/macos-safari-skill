-- Get URL of current tab (front window). argv: [tabIndex] default: current
on run argv
	tell application "Safari"
		if (count of windows) is 0 then
			return ""
		end if
		if (count of argv) ≥ 1 then
			return URL of tab (item 1 of argv) as integer of front window
		end if
		return URL of current tab of front window
	end tell
end run
