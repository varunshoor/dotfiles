local spaces = require("hs._asm.undocumented.spaces")
local screens = require("screens") -- Load the local screens module
local browser = require("browser") -- Load the local browser default updating module
local wf = hs.window.filter
local logLevel = "debug" -- generally want 'debug' or 'info'
local log = hs.logger.new("wincent", logLevel)

-- Set the Space IDs here after you have found them out using hs.alert.show(spaceNumericID)
-- local primarySpace = 1
-- local devSpace = 3
-- local creativeSpace = 4
-- local messagingSpace = 5

--[[
function moveBearToSpace(spaceID)
    local bearApp = hs.application.find('net.shinyfrog.bear')
    if bearApp == nil then
        print('couldnt find bear')
        return
    end

    --for _, window in pairs(bearApp:visibleWindows()) do
    --end

    local bearWindow = bearApp:mainWindow()
    if bearWindow ~= nil then
--        spaces.moveWindowToSpace(bearWindow:id(), spaceID)
    end
end

local reorganizeWindowsInSpace = function(spaceNumber)
    local spaceNumericID = spaces.activeSpace()
    if (spaceNumericID <= 0) then
        return
    end
    --        hs.alert.show(spaceNumericID)

    if spaceNumericID == primarySpace then
        print('activating primary space')
        moveBearToSpace(spaceNumericID)
    elseif spaceNumericID == devSpace then
        print('activating dev space')
        moveBearToSpace(spaceNumericID)
    end
end

local spacewatcher = hs.spaces.watcher.new(reorganizeWindowsInSpace)
spacewatcher:start()


--]]

-- On Sleep and Wake Up
local function on_pow(event)
	log.df("Event: %d", event)
	log.df("screensDidWake: %d", hs.caffeinate.watcher.screensDidWake)
	log.df("sessionDidBecomeActive: %d", hs.caffeinate.watcher.sessionDidBecomeActive)
	log.df("screensDidUnlock: %d", hs.caffeinate.watcher.screensDidUnlock)
	log.df("systemDidWake: %d", hs.caffeinate.watcher.systemDidWake)

	if
		event == hs.caffeinate.watcher.screensDidWake
		or event == hs.caffeinate.watcher.sessionDidBecomeActive
		or event == hs.caffeinate.watcher.screensDidUnlock
		or event == hs.caffeinate.watcher.systemDidWake
	then
		-- Open Bear Journal
		--        hs.alert.show('On Wake Up')
		log.df("Reorienting the apps")
		-- screens.tearDownEventHandling()
		screens.initEventHandling()

		-- log.df("Activating Bear")
		-- hs.execute("/Users/varunshoor/dev/bear-daily-note/daily-note.sh &", true)
		-- log.df("Activated")
	end

	if event == hs.caffeinate.watcher.screensaverDidStop then
		-- hs.alert.show("On Wake Up 2")
	end

	if
		event == hs.caffeinate.watcher.screensDidSleep
		or event == hs.caffeinate.watcher.systemWillSleep
		or event == hs.caffeinate.watcher.systemWillPowerOff
		or event == hs.caffeinate.watcher.sessionDidResignActive
		or event == hs.caffeinate.watcher.screensDidLock
	then
		-- Sleep
		log.df("On Sleep")
	end
end

pow = hs.caffeinate.watcher.new(on_pow)
pow:start()

-- USB Watcher to Monitor for Display Plugin
--[[
usbWatcher = nil
function usbDeviceCallback(data)
    if (data["productName"] == "Pro Display XDR") then
        if (data["eventType"] == "added") then
            hs.alert.show("Added " .. data["productName"])
        elseif (data["eventType"] == "removed") then
            hs.alert.show("Removed " .. data["productName"])
        end
    elseif (data["productName"] == "Studio Display") then
        if (data["eventType"] == "added") then
            hs.alert.show("Added " .. data["productName"])
        elseif (data["eventType"] == "removed") then
            hs.alert.show("Removed " .. data["productName"])
        end
    end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
--]]

-- Temporary Experiments

-- function MoveWindowToSpace(isPrevious)
-- 	local activeSpaceID = spaces.activeSpace()
-- 	hs.alert.show(activeSpaceID)
--
-- 	local nextSpaceID = primarySpace
-- 	local previousSpaceID = primarySpace
--
-- 	if activeSpaceID == primarySpace then
-- 		nextSpaceID = devSpace
-- 		previousSpaceID = messagingSpace
-- 	elseif activeSpaceID == devSpace then
-- 		nextSpaceID = creativeSpace
-- 		previousSpaceID = primarySpace
-- 	elseif activeSpaceID == creativeSpace then
-- 		nextSpaceID = messagingSpace
-- 		previousSpaceID = devSpace
-- 	elseif activeSpaceID == messagingSpace then
-- 		nextSpaceID = primarySpace
-- 		previousSpaceID = creativeSpace
-- 	end
--
-- 	local win = hs.window.focusedWindow() -- current window
-- 	local uuid = win:screen():spacesUUID() -- uuid for current screen
--
-- 	local spaceID = nextSpaceID -- internal index for sp
-- 	if isPrevious then
-- 		spaceID = previousSpaceID
-- 	end
--
-- 	hs.alert.show(spaceID)
--
-- 	spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
-- 	--    spaces.changeToSpace(spaceID)              -- follow window to new space
-- end
--
-- hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "left", function()
-- 	hs.alert.show("shift left")
-- 	MoveWindowToSpace(true)
-- end)
--
-- hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "right", function()
-- 	hs.alert.show("shift left")
-- 	MoveWindowToSpace(false)
-- end)

--[[ Move Window to Space

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, 'right', function()
    MoveWindowToSpace(false)
end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, 'left', function()
    MoveWindowToSpace(true)
end)
--]]

require("keymaps")

-- Auto Reload Config
local function reloadConfig(files)
	local doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end

	if doReload then
		screens.tearDownEventHandling()
		browser.TearDownEventHandling()
		pow:stop()

		hs.reload()
	end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("Hammerspoon Config Reloaded Automatically")
