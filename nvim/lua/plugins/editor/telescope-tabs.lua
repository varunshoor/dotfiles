return {
  "LukasPietzschmann/telescope-tabs",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    close_tab_shortcut_i = "<C-d>",
    close_tab_shortcut_n = "d",
  },
  config = function(_, opts)
    require("telescope-tabs").setup(opts)
  end,
}
