-- Shows live progress of Github actions and allows triggering them
-- See: https://github.com/topaxi/gh-actions.nvim

return {
  "topaxi/gh-actions.nvim",
  lazy = true,
  cmd = "GhActions",
  keys = {
    { "<leader>gh", "<cmd>GhActions<cr>", desc = "Open Github Actions" },
  },
  -- optional, you can also install and use `yq` instead.
  build = "make",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  opts = {},
  config = function(_, opts)
    require("gh-actions").setup(opts)
  end,
}
