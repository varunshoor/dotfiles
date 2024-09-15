return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  {
    "LunarVim/onedarker.nvim",
    lazy = true,
  },
  {
    "binhtran432k/dracula.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_better_performance = 1
    end,
  },

  {
    "EdenEast/nightfox.nvim",
  },

  {
    "martinsione/darkplus.nvim",
    lazy = true,
  },

  {
    "ray-x/aurora",
    lazy = true,
    setup = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      vim.g.aurora_bold = 1
    end,
  },

  { "catppuccin/nvim", as = "catppuccin", lazy = true },

  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = true },

  -- Configure LazyVim to load the theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dayfox",
    },
  },
}
