-- Creates links to Github for selection or line
-- See: https://github.com/linrongbin16/gitlinker.nvim

return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = {},
  keys = {
    { "<leader>gl", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
    { "<leader>gL", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
  },
}
