-- Cutlass overrides the delete operations to actually just delete and not affect the current yank.

return {
  "gbprod/cutlass.nvim",
  opts = {
    cut_key = "x",
  },
  config = function(_, opts)
    require("cutlass").setup(opts)
  end,
}
