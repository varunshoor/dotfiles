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
