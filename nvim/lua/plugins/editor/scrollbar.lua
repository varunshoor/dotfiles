-- Extensible scrollbar showing diagnostics, git signs etc.

return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup()
  end,
}
