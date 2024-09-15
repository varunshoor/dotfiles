-- Smart and Powerful commenting plugin for neovim

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
  end,
}
