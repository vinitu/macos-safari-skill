-- List window names (tab count per window). One per line.
on run argv
	tell application "Safari"
		set wins to every window
		set output to ""
		repeat with w in wins
			set output to output & (name of w) & linefeed
		end repeat
		return output
	end tell
end run
