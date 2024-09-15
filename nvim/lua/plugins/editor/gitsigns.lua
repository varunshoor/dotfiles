-- Display Git changes in the sign column

return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  opts = {
    current_line_blame = true, -- Display the git blame at the end of current line
  },
}
