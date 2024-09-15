-- Move lines and blocks of text vertically and horizontally

return {
  "booperlv/nvim-gomove",
  event = "VeryLazy",
  opts = {
    -- whether or not to map default key bindings, (true/false)
    map_defaults = false,
    -- whether or not to reindent lines moved vertically (true/false)
    reindent = true,
    -- whether or not to undojoin same direction moves (true/false)
    undojoin = true,
    -- whether to not to move past end column when moving blocks horizontally, (true/false)
    move_past_end_col = false,
  },
  config = function()
    require("gomove").setup()

    vim.keymap.set("n", "<M-Down>", "<Plug>GoNSMDown", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-Up>", "<Plug>GoNSMUp", { noremap = true, silent = true })

    vim.keymap.set("v", "<M-Down>", "<Plug>GoVSMDown", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-Up>", "<Plug>GoVSMUp", { noremap = true, silent = true })
  end,
}
