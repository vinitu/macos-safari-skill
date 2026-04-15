-- Open a new empty Safari window.
-- Returns JSON: {"success":true}
on run argv
	tell application "Safari"
		make new document
		activate
	end tell
	return "{\"success\":true}"
end run
