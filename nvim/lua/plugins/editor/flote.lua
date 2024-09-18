-- Creates a modal for project specific notes
-- See: https://github.com/JellyApple102/flote.nvim

return {
  "JellyApple102/flote.nvim",
  lazy = true,
  opts = {},
  keys = {
    { "<leader>n", "<cmd>Flote<cr>", desc = "Open Project Notes" },
  },
  config = function(_, opts)
    require("flote").setup(opts)
  end,
}
