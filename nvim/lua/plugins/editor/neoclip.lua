-- Clipboard History
-- Hotkey configured in Telescope config
-- See: https://github.com/AckslD/nvim-neoclip.lua

return {
  "AckslD/nvim-neoclip.lua",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("neoclip").setup()
  end,
}
