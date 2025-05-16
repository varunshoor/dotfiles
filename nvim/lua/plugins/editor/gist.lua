-- Better than the neovim Gist plugin
-- Set PAT in ~/.gist-vim with token xxx
-- See: https://github.com/mattn/vim-gist

return {
  "mattn/vim-gist",
  dependencies = { "mattn/webapi-vim" },
  lazy = true,
  keys = {
    {
      "<leader>gg",
      ":'<,'>Gist<cr>",
      mode = "v",
      desc = "Create Gist from Selection",
      silent = true,
    },
    {
      "<leader>gg",
      ":Gist<cr>",
      mode = "n",
      desc = "Create Gist from File",
      silent = true,
    },
  },
}
