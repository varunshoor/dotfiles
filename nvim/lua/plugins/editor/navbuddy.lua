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
      opts = { lsp = { auto_attach = true } },
    },
  },
  keys = {
    { ";;", ":Navbuddy<CR>", mode = { "n" }, desc = "Navigate symbols" },
  },
  event = "VeryLazy",
}
