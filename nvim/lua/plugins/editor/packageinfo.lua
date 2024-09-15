-- Displays the latest version of packages in package.json

return {
  "vuki656/package-info.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("package-info").setup({
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
        outdated = "#d19a66", -- Text color for outdated dependency virtual text
      },
    })
  end,
}
