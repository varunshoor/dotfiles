-- Rest client in neovim
return {
  "rest-nvim/rest.nvim",
  ft = "http",
  dependencies = { "luarocks.nvim" },
  config = function()
    require("rest-nvim").setup()

    -- rest.nvim
    vim.keymap.set({ "n" }, "<leader>rr", "<Plug>RestNvim")
    vim.keymap.set({ "n" }, "<leader>rp", "<Plug>RestNvimPreview")
  end,
}
