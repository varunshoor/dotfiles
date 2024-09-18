-- Incredible plugin to diff files in a separate tab
-- See: https://github.com/sindrets/diffview.nvim

return {
  "sindrets/diffview.nvim",
  lazy = true,
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", mode = { "n", "v" }, desc = "Open Diff View on Contents" },
    { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", mode = { "n", "v" }, desc = "File History Current File" },
    { "<leader>dF", "<cmd>DiffviewFileHistory<cr>", mode = { "n", "v" }, desc = "File History Current Branch" },
  },
}
