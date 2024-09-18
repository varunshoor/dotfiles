-- Neovim plugin for splitting/joining blocks of code like arrays, hashes, statements, objects, dictionaries, etc.
-- See: https://github.com/Wansmer/treesj

return {
  "Wansmer/treesj",
  lazy = true,
  keys = { "<space>m", "<space>j", "<space>s" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      --[[ your config ]]
    })
  end,
}
