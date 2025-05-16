-- Nested navigation for files with symbols
-- See: https://github.com/SmiteshP/nvim-navbuddy

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        local actions = require("nvim-navbuddy.actions")

        require("nvim-navbuddy").setup({
          lsp = { auto_attach = true },
          window = {
            size = "75%",
            border = "rounded",
          },
          mappings = {
            ["<Left>"] = actions.parent(),
            ["<Right>"] = actions.children(),
          },
        })
      end,
    },
  },
  keys = {
    { ";;", ":Navbuddy<CR>", mode = { "n" }, desc = "Navigate symbols" },
  },
  event = "VeryLazy",
}
