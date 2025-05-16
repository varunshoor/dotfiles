-- Neogen is a code annotation generator for Neovim, which can be used to automatically generate comments and documentation for your code.

return {
  "danymat/neogen",
  config = true,
  lazy = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
  keys = {
    { "<leader>cn", ":lua require('neogen').generate()<CR>", mode = { "n" }, desc = "Generate comments" },
  },
}
