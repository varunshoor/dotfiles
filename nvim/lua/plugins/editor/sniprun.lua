-- Run lines/blocs of code
-- See: https://github.com/michaelb/sniprun
-- TODO: Go isn't running

return {
  "michaelb/sniprun",
  lazy = true,
  branch = "master",

  build = "sh install.sh",
  cmd = { "SnipRun", "SnipRunOperator", "SnipRunLive", "SnipClose" },

  keys = {
    { "<leader>rs", ":SnipRun<CR>", mode = "n", desc = "Run Snippet" },
    { "<leader>rf", ":%SnipRun<CR>", mode = "n", desc = "Run File" },
    { "<leader>rc", ":SnipClose<CR>", mode = "n", desc = "Close Snippet" },
    { "<leader>rs", ":SnipRun<CR>", mode = "v", desc = "Run Snippet" },
    { "<leader>rf", ":%SnipRun<CR>", mode = "v", desc = "Run File" },
    { "<leader>rc", ":SnipClose<CR>", mode = "v", desc = "Close Snippet" },
  },

  config = function()
    require("sniprun").setup({
      display = {
        "VirtualTextOk",
        "Terminal",
      },
    })
  end,
}
