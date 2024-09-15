-- numb.nvim is a Neovim plugin that peeks lines of the buffer in non-obtrusive way.
-- Shows you the line before you jump to it using :[num]

return {
  "nacro90/numb.nvim",
  event = "VeryLazy",
  config = function()
    require("numb").setup()
  end,
}
