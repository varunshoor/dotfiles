return {
  "sindrets/diffview.nvim",
  lazy = true,
  keys = {
    { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", mode = { "n", "v" }, desc = "File History Current File" },
    { "<leader>dF", "<cmd>DiffviewFileHistory<cr>", mode = { "n", "v" }, desc = "File History Current Branch" },
  },
}
