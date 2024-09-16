-- Smart and Powerful commenting plugin for neovim
-- https://github.com/numToStr/Comment.nvim

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
  end,
}
