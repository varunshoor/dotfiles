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
        is_hidden_file = function(name, bufnr)
          local m = name:match("^%.")
          return m ~= nil
        end,
      },
      keymaps = {
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["b"] = { "actions.parent", mode = "n" },
      },
    })

    vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>Oil %:p:h<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>O", "<cmd>Oil .<cr>", { noremap = true, silent = true })
  end,
}
