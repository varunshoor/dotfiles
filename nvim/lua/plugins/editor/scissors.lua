return {
  "chrisgrieser/nvim-scissors",
  event = "VeryLazy",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = "~/.config/nvim/snippets/vscode",
    editSnippetPopup = {
      keymaps = {
        deleteSnippet = "<C-z>",
      },
    },
  },
  config = function(_, opts)
    require("scissors").setup(opts)

    vim.keymap.set("n", "<leader>sn", "<cmd>ScissorsAddNewSnippet<cr>")
    vim.keymap.set("n", "<leader>se", "<cmd>ScissorsEditSnippet<cr>")
    vim.keymap.set("v", "<leader>sn", "<cmd>ScissorsAddNewSnippet<cr>")
    vim.keymap.set("v", "<leader>se", "<cmd>ScissorsEditSnippet<cr>")
  end,
}
