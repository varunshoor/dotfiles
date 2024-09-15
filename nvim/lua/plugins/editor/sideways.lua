-- Allows moving arguments, parameters, and other delimited items left and right.

return {
  "AndrewRadev/sideways.vim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<M-[>", ":SidewaysLeft<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<M-]>", ":SidewaysRight<CR>", { silent = true, noremap = true })
  end,
}
