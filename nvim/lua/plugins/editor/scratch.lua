-- Create temporary playground files effortlessly
-- See: https://github.com/LintaoAmons/scratch.nvim
-- TODO: Go doesn't show up

return {
  "LintaoAmons/scratch.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>sc", ":Scratch<CR>", desc = "New Scratch Playground" },
    { "<leader>so", ":ScratchOpen<CR>", desc = "Open Scratch Files" },
  },
  opts = {},
}
