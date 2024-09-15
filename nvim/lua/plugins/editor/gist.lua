-- Create Gists from neovim

return {
  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    lazy = true,
    keymaps = {
      n = {
        { "<leader>sg", "<cmd>GistCreate public=false<cr>", { noremap = true, silent = true } },
        { "<leader>sf", "<cmd>GistCreateFromFile public=false<cr>", { noremap = true, silent = true } },
      },
    },
    init = function()
      local wk = require("which-key")
    end,

    config = true,
  },
  -- `GistsList` opens the selected gif in a terminal buffer,
  -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
  -- and prevents neovim buffer inception
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
}
