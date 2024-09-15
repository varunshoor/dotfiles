-- Revolutionize Your Neovim Tab Workflow: Introducing Enhanced Tab Scoping!

return {
  "tiagovla/scope.nvim",
  opts = {},
  config = function(_, opts)
    require("scope").setup(opts)
  end,
}
