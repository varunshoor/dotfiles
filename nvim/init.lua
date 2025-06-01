-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Define your desired colorschemes for different times of the day
local defaultTheme = "dayfox"
local colorschemes = {
  morning = {
    nvim = defaultTheme,
    lualine = defaultTheme,
  },
  afternoon = {
    nvim = defaultTheme,
    lualine = defaultTheme,
  },
  evening = {
    nvim = defaultTheme,
    lualine = defaultTheme,
  },
  night = {
    nvim = defaultTheme,
    lualine = defaultTheme,
  },
}

-- Function to set the colorscheme
local function setColorscheme(scheme)
  vim.cmd("colorscheme " .. scheme)
end

local function getTimeOfDay()
  local current_hour = tonumber(os.date("%H"))

  if current_hour >= 6 and current_hour < 12 then
    return "morning"
  elseif current_hour >= 12 and current_hour < 18 then
    return "afternoon"
  elseif current_hour >= 18 and current_hour < 21 then
    return "evening"
  else
    return "night"
  end
end

local timeOfDay = getTimeOfDay()
timeOfDay = "morning"
-- Set initial colorscheme based on current time of day
setColorscheme(colorschemes[timeOfDay].nvim)

-- Update Lua Line Colors
local lualine = require("lualine")

-- Fetch the current theme colors
local lualineTheme = require("lualine.themes." .. colorschemes[timeOfDay].lualine)

local newColors = {
  blue = "#91ddff",
  green = "#56f378",
  violet = "#FF62EF",
  yellow = "#FFDA8B",
  orange = "#ff9248",
  black = "#000001",
  fg = "#3d2b5a",
}

lualineTheme.normal.a.bg = newColors.blue
lualineTheme.insert.a.bg = newColors.green
lualineTheme.visual.a.bg = newColors.violet
lualineTheme.normal.a.fg = newColors.fg
lualineTheme.insert.a.fg = newColors.fg
lualineTheme.visual.a.fg = newColors.fg

lualineTheme.command = {
  a = {
    gui = "bold",
    bg = newColors.yellow,
    fg = newColors.black,
  },
}

lualine.setup({
  options = {
    theme = lualineTheme,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_z = {},
  },
})
