-- Neovim plugin to automatic change normal string to template string in JS like languages

return {
  "axelvc/template-string.nvim",
  config = function()
    require("template-string").setup()
  end,
}
