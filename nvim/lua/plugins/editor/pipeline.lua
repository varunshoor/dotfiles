-- Shows live progress of Github actions and allows triggering them
-- See: https://github.com/topaxi/pipeline.nvim

return {
  "topaxi/pipeline.nvim",
  lazy = true,
  keys = {
    { "<leader>ci", "<cmd>Pipeline<cr>", desc = "Open Github Actions" },
  },
  build = "make",
  -- dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  -- opts = {},
  -- config = function(_, opts)
  --   require("gh-actions").setup(opts)
  -- end,
}
