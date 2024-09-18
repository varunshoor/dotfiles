-- Rest client in neovim
-- See: https://github.com/rest-nvim/rest.nvim

return {
  "rest-nvim/rest.nvim",
  ft = "http",
  dependencies = { "luarocks.nvim" },
  keys = {
    { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run request under cursor" },
    { "<leader>rl", "<cmd>Rest last<cr>", desc = "Run last request" },
  },
}
