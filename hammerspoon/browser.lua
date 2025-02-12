-- Switches default browser based on which space is active
local spaces = require("hs._asm.undocumented.spaces")
local logLevel = "debug" -- generally want 'debug' or 'info'
local log = hs.logger.new("wincent", logLevel)

local primarySpace = 1
local devSpace = 3
local devSpaceSecondary = 2
local creativeSpace = 4
local messagingSpace = 5

local spaceWatcher = nil

local function handleSpacesEvent()
	local activeSpaceID = spaces.activeSpace()
	if activeSpaceID <= 0 then
		return
	end

	log.df("Active Space: %d", activeSpaceID)

	if activeSpaceID == primarySpace then
		log.df("Activating primary space")
		-- Change default browser to Safari
		log.df("Changing default browser to Safari")
		os.execute("/opt/homebrew/bin/defbro com.apple.Safari &")
	elseif activeSpaceID == devSpace or activeSpaceID == devSpaceSecondary then
		log.df("Activating dev space")
		-- Change default browser to Min
		log.df("Changing default browser to Min")
		os.execute("/opt/homebrew/bin/defbro com.electron.min &")
	elseif activeSpaceID == creativeSpace or activeSpaceID == messagingSpace then
		-- Change default browser to Safari
		log.df("Changing default browser to Safari")
		os.execute("/opt/homebrew/bin/defbro com.apple.Safari &")
	end
end

function InitEventHandling()
	spaceWatcher = hs.spaces.watcher.new(handleSpacesEvent)
	spaceWatcher:start()
end

function TearDownEventHandling()
	if spaceWatcher then
		spaceWatcher:stop()
		spaceWatcher = nil
	end
end

InitEventHandling()

return { tearDownEventHandling = TearDownEventHandling }
