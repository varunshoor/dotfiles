return {
  "gbprod/substitute.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    require("substitute").setup()

    vim.keymap.set("n", "rl", require("substitute").line, { noremap = true })
    vim.keymap.set("n", "R", require("substitute").eol, { noremap = true })
    vim.keymap.set("x", "r", require("substitute").visual, { noremap = true })
  end,
}
