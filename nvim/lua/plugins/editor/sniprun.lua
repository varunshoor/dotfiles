return {
  "michaelb/sniprun",
  lazy = true,
  branch = "master",

  build = "sh install.sh",
  cmd = { "SnipRun", "SnipRunOperator", "SnipRunLive", "SnipClose" },

  keymaps = {
    { "n", "<leader>rs", ":SnipRun<CR>", { noremap = true, silent = true } },
    { "v", "<leader>rs", ":SnipRun<CR>", { noremap = true, silent = true } },
    { "n", "<leader>rf", ":%SnipRun<CR>", { noremap = true, silent = true } },
    { "v", "<leader>rf", ":%SnipRun<CR>", { noremap = true, silent = true } },
    { "n", "<leader>rc", ":SnipClose<CR>", { noremap = true, silent = true } },
    { "v", "<leader>rc", ":SnipClose<CR>", { noremap = true, silent = true } },
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
