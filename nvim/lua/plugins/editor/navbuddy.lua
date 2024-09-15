-- Nested navigation for files with symbols

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
  keymaps = {
    { "n", "<leader>;", ":Navbuddy<CR>", { noremap = true, silent = true } },
  },
  event = "VeryLazy",
}
