-- See: https://searchcode.com/codesearch/view/114795999/

local displays = hs.screen.allScreens()
hs.grid.setMargins({ 0, 0 })
hs.grid.setGrid("12x12") -- allows us to place on quarters, thirds and halves
hs.window.animationDuration = 0 -- disable animations

local screenCount = #hs.screen.allScreens()
local screenGeometries = hs.fnutils.map(hs.screen.allScreens(), function(screen)
	return screen:currentMode().desc
end)

local logLevel = "debug" -- generally want 'debug' or 'info'
local log = hs.logger.new("wincent", logLevel)

local laptopScreen = "Built-in Retina Display"
local proDisplayXDRScreen = "Pro Display XDR"
local studioDisplayScreen = "Studio Display"

print("Total Screen Count: " .. screenCount)

local grid = {
	topHalf = "0,0 12x6",
	topThird = "0,0 12x4",
	topTwoThirds = "0,0 12x8",
	rightHalf = "6,0 6x12",
	rightThird = "8,0 4x12",
	rightTwoThirds = "4,0 8x12",
	bottomHalf = "0,6 12x6",
	bottomThird = "0,8 12x4",
	bottomTwoThirds = "0,4 12x8",
	leftHalf = "0,0 6x12",
	leftThird = "0,0 4x12",
	leftTwoThirds = "0,0 8x12",
	topLeft = "0,0 6x6",
	topRight = "6,0 6x6",
	bottomRight = "6,6 6x6",
	bottomLeft = "0,6 6x6",
	fullScreen = "0,0 12x12",
	centeredBig = "3,3 6x6",
	centeredSmall = "4,4 4x4",
}

local globalWatcher = nil
local screenWatcher = nil
local spaceWatcher = nil

local focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.primaryScreen())
	elseif proDisplayXDRScreenActive == true then
		hs.grid.set(window, grid.rightHalf, hs.screen.find(proDisplayXDRScreen))
	end
end

local focusWindowOnRightHalfOnAllDisplays = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.rightHalf, hs.screen.primaryScreen())
	elseif proDisplayXDRScreenActive == true then
		hs.grid.set(window, grid.rightHalf, hs.screen.find(proDisplayXDRScreen))
	end
end

local focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.primaryScreen())
	elseif proDisplayXDRScreenActive == true then
		hs.grid.set(window, grid.leftHalf, hs.screen.find(proDisplayXDRScreen))
	end
end

local focusWindowAlwaysFullScreen = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.primaryScreen())
	elseif proDisplayXDRScreenActive == true then
		log.wf("configuring window to be full screen %s", window:application():bundleID())
		hs.grid.set(window, grid.fullScreen, hs.screen.find(proDisplayXDRScreen))
	end
end

local focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.primaryScreen())
	elseif currentScreenCount == 1 and proDisplayXDRScreenActive == true then
		hs.grid.set(window, grid.rightHalf, hs.screen.primaryScreen())
	elseif studioDisplayScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.find(studioDisplayScreen))
	end
end

local focusWindowOnHalfStudioDisplayOrHalfProDisplayOrFullScreenLaptop = function(
	window,
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	if currentScreenCount == 1 and laptopScreenActive == true then
		hs.grid.set(window, grid.fullScreen, hs.screen.primaryScreen())
	elseif currentScreenCount == 1 and proDisplayXDRScreenActive == true then
		hs.grid.set(window, grid.rightHalf, hs.screen.primaryScreen())
	elseif studioDisplayScreenActive == true then
		hs.grid.set(window, grid.topHalf, hs.screen.find(studioDisplayScreen))
	end
end

local layoutConfig = {
	_before_ = function() end,

	_after_ = function() end,

	["com.googlecode.iterm2"] = focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay,
	["com.spotify.client"] = focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay,
	["org.hammerspoon.Hammerspoon"] = focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay,
	["com.insomnia.app"] = focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay,

	["com.apple.finder"] = focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop,
	["com.utmapp.UTM"] = focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop,
	["com.pgadmin.pgadmin4"] = focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop,
	["com.apple.MobileSMS"] = focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop,
	["com.apple.TextEdit"] = focusWindowOnRightHalfOnAllDisplays,
	["com.anthropic.claudefordesktop"] = focusWindowOnRightHalfOnAllDisplays,

	["net.shinyfrog.bear"] = focusWindowOnRightHalfOnAllDisplays,
	["com.tinyspeck.slackmacgap"] = focusWindowOnRightHalfOnAllDisplays,
	["WhatsApp"] = focusWindowOnRightHalfOnProDisplayAndFullScreenOnLaptop,

	["com.apple.Safari"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.electron.min"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.cron.electron"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.readdle.PDFExpert-Mac"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.jetbrains.WebStorm"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.google.Chrome"] = focusWindowOnLeftHalfOnProDisplayAndFullScreenOnLaptop,
	["com.google.Chrome.dev"] = focusWindowRightHalfOnProDisplayAndFullScreenLaptopOrFullScreenStudioDisplay,
	["com.figma.Desktop"] = focusWindowAlwaysFullScreen,
	["net.kovidgoyal.kitty"] = focusWindowAlwaysFullScreen,
}

function activateLayout(
	screens,
	currentScreenCount,
	laptopScreenActive,
	proDisplayXDRScreenActive,
	studioDisplayScreenActive
)
	layoutConfig._before_()

	for bundleID, callback in pairs(layoutConfig) do
		local application = hs.application.get(bundleID)
		log.df("Processing layout for bundle: %s", bundleID)

		if application then
			local windows = application:visibleWindows()
			for _, window in pairs(windows) do
				if window:isStandard() then
					log.df("Processing Window: %s", window:title())

					callback(
						window,
						screens,
						currentScreenCount,
						laptopScreenActive,
						proDisplayXDRScreenActive,
						studioDisplayScreenActive
					)
				end
			end
		end
	end

	layoutConfig._after_()
end

-- Event-handling
--
-- This will become a lot easier once `hs.window.filter`
-- (http://www.hammerspoon.org/docs/hs.window.filter.html) moves out of
-- "experimental" status, but until then, using a manual approach as
-- demonstrated at: https://gist.github.com/tmandry/a5b1ab6d6ea012c1e8c5

local watchers = {}
local events = hs.uielement.watcher

function handleGlobalEvent(name, eventType, app)
	if eventType == hs.application.watcher.launched then
		log.df("[event] launched %s", app:bundleID())
		watchApp(app)
	elseif eventType == hs.application.watcher.terminated then
		-- Only the PID is set for terminated apps, so can't log bundleID.
		local pid = app:pid()
		log.df("[event] terminated PID %d", pid)
		unwatchApp(pid)
	end
end

function handleAppEvent(element, event)
	if event == events.windowCreated then
		if
			pcall(function()
				log.df("[event] window %s created", element:id())

				local application = element:application()
				if application then
					local appName = application:name()
					local bundleID = application:bundleID()
					log.df("APP %s %s", appName, bundleID)

					local axui = require("hs.axuielement")
					if appName == "CoreServicesUIAgent" then
						-- Everytime we change the browser we get a system prompt, this accepts the new default browser automatically
						local coreServiceWindow = axui.windowElement(application:focusedWindow())
						coreServiceWindow:elementSearch(
							function(msg, r, c)
								if msg == "completed" and c == 1 and r[1] then
									r[1]:performAction("AXPress")
								end
							end,
							axui.searchCriteriaFunction({
								{ attribute = "AXRole", value = "AXButton" },
								{ attribute = "AXTitle", value = "Use", pattern = true },
							}),
							{ depth = 5 }
						)
					end
				end
			end)
		then
			watchWindow(element)
			-- else
			-- 	log.df("error thrown trying to access element in handleAppEvent")
		end
	else
		log.wf("unexpected app event %d received", event)
	end
end

function handleWindowEvent(window, event, watcher, info)
	if event == events.elementDestroyed then
		log.df("[event] window %s destroyed", info.id)
		watcher:stop()
		watchers[info.pid].windows[info.id] = nil
	else
		log.wf("unexpected window event %d received", event)
	end
end

function handleScreenEvent(forceExecute)
	-- Make sure that something noteworthy (display count, geometry) actually
	-- changed.
	local screens = hs.screen.allScreens()
	local laptopScreenActive = false
	local proDisplayXDRScreenActive = false
	local studioDisplayScreenActive = false

	if #screens == screenCount and forceExecute ~= true then
		local changed = false
		for i, screen in pairs(screens) do
			if screenGeometries[i] ~= screen:currentMode().desc then
				changed = true
			end
		end
		if not changed then
			return
		end
	end

	for i, screen in pairs(screens) do
		if screen:name() == laptopScreen then
			laptopScreenActive = true
		elseif screen:name() == proDisplayXDRScreen then
			proDisplayXDRScreenActive = true
		elseif screen:name() == studioDisplayScreen then
			studioDisplayScreenActive = true
		end
	end

	screenCount = #screens
	activateLayout(screens, screenCount, laptopScreenActive, proDisplayXDRScreenActive, studioDisplayScreenActive)
end

function handleSpacesEvent()
	handleScreenEvent(true)
end

--[[
-- Debug for getting screen names
-- "Pro Display XDR", "Built-in Retina Display", "Studio Display"
local screens = hs.screen.allScreens()
for i, screen in pairs(screens) do
    hs.alert.show(screen:name())
end
--]]

function watchApp(app)
	local pid = app:pid()
	if watchers[pid] then
		log.wf("attempted watch for already-watched PID %d", pid)
		return
	end

	-- Watch for new windows.
	local watcher = app:newWatcher(handleAppEvent)
	watchers[pid] = {
		watcher = watcher,
		windows = {},
	}

	if not events.windowCreated then
		return
	end

	watcher:start({ events.windowCreated })

	-- Watch already-existing windows.
	for _, window in pairs(app:allWindows()) do
		watchWindow(window)
	end
end

function unwatchApp(pid)
	local appWatcher = watchers[pid]
	if not appWatcher then
		log.wf("attempted unwatch for unknown PID %d", pid)
		return
	end

	appWatcher.watcher:stop()
	for _, watcher in pairs(appWatcher.windows) do
		watcher:stop()
	end
	watchers[pid] = nil
end

function watchWindow(window)
	local application = window:application()
	if not application then
		return
	end

	local pid = application:pid()
	local windows = watchers[pid].windows

	if window:isStandard() then
		local screens = hs.screen.allScreens()
		local laptopScreenActive = false
		local proDisplayXDRScreenActive = false
		local studioDisplayScreenActive = false

		for i, screen in pairs(screens) do
			if screen:name() == laptopScreen then
				laptopScreenActive = true
			elseif screen:name() == proDisplayXDRScreen then
				proDisplayXDRScreenActive = true
			elseif screen:name() == studioDisplayScreen then
				studioDisplayScreenActive = true
			end
		end

		-- Do initial layout-handling.
		local bundleID = application:bundleID()
		log.df(bundleID)
		if layoutConfig[bundleID] then
			log.wf("Found a layout config for %s, configuring..", bundleID)

			layoutConfig[bundleID](
				window,
				screens,
				#screens,
				laptopScreenActive,
				proDisplayXDRScreenActive,
				studioDisplayScreenActive
			)
		end

		-- Watch for window-closed events.
		local id = window:id()
		if id then
			if not windows[id] then
				local watcher = window:newWatcher(handleWindowEvent, {
					id = id,
					pid = pid,
				})
				windows[id] = watcher
				watcher:start({ events.elementDestroyed })
			end
		end
	end
end

function initEventHandling()
	-- Watch for application-level events.
	if not globalWatcher then
		globalWatcher = hs.application.watcher.new(handleGlobalEvent)
		globalWatcher:start()
	end

	-- Watch already-running applications.
	local apps = hs.application.runningApplications()
	for _, app in pairs(apps) do
		local bundleID = app:bundleID()

		-- Ignore watching Hammerspoon and Contexts windows
		if bundleID ~= "com.contextsformac.Contexts" then
			watchApp(app)
		end
	end

	-- Watch for screen changes.
	if not screenWatcher then
		screenWatcher = hs.screen.watcher.new(handleScreenEvent)
		screenWatcher:start()
	end

	if not spaceWatcher then
		spaceWatcher = hs.spaces.watcher.new(handleSpacesEvent)
		spaceWatcher:start()
	end

	hs.alert.show("Initialized event handling")
	-- This is where you should insert rearranging of windows as this event runs most reliably after sleep
end

function TearDownEventHandling()
	if globalWatcher then
		globalWatcher:stop()
		globalWatcher = nil
	end

	if screenWatcher then
		screenWatcher:stop()
		screenWatcher = nil
	end

	if spaceWatcher then
		spaceWatcher:stop()
		spaceWatcher = nil
	end

	for pid, _ in pairs(watchers) do
		unwatchApp(pid)
	end
end

initEventHandling()

return { tearDownEventHandling = tearDownEventHandling, initEventHandling = initEventHandling }
