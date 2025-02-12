-- Display the application bundle
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "B", function()
	local win = hs.window.focusedWindow()
	local app = win:application()
	hs.alert.show(app:bundleID())
end)
