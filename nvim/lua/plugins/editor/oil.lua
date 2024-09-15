-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.

return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      keymaps = {
        ["<Esc>"] = "actions.close",
      },
    })

    vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>Oil %:p:h<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>O", "<cmd>Oil .<cr>", { noremap = true, silent = true })
  end,
}
