-- Move lines and blocks of text vertically and horizontally
-- See: https://github.com/booperlv/nvim-gomove

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
  keys = {
    { "<M-Down>", "<Plug>GoNSMDown", mode = { "n" }, desc = "Move line down" },
    { "<M-Up>", "<Plug>GoNSMUp", mode = { "n" }, desc = "Move line up" },
    { "<M-Down>", "<Plug>GoVSMDown", mode = { "v" }, desc = "Move selection down" },
    { "<M-Up>", "<Plug>GoVSMUp", mode = { "v" }, desc = "Move selection up" },
  },
  config = function()
    require("gomove").setup()
  end,
}
