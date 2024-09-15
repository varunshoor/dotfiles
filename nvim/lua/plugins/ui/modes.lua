-- Prismatic line decorations for when you switch modes in Neovim.
-- Highlights the line color based on current mode

return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#31cc79",
        visual = "#9745be",
      },
      line_opacity = 0.20,
    })
  end,
}
