return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>ad",
      mode = { "n", "x", "v" },
      function()
        require("wtf").ai()
      end,
      desc = "Debug diagnostic with AI",
    },
    {
      mode = { "n" },
      "<leader>S",
      function()
        require("wtf").search()
      end,
      desc = "Search diagnostic with Google",
    },
  },
}
