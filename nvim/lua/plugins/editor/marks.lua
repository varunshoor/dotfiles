-- A better user experience for interacting with and manipulating Vim marks
-- See: https://github.com/chentoast/marks.nvim

return {
  "chentoast/marks.nvim",
  -- event = "VeryLazy",
  keys = {
    { "mm", "<cmd>lua require('marks').set_next()<CR>", { desc = "Set next mark" } },
    { "m;", "<cmd>lua require('marks').toggle()<CR>", { desc = "Toggle mark" } },
    { "mn", "<cmd>lua require('marks').next()<CR>", { desc = "Next mark" } },
    { "mp", "<cmd>lua require('marks').prev()<CR>", { desc = "Previous mark" } },
    { "ml", "<cmd>MarksListAll<CR>", { desc = "List all marks" } },
    { "md", "<cmd>lua require('marks').delete_line()<CR>", { desc = "Delete mark" } },
    { "mD", "<cmd>lua require('marks').delete_buf()<CR>", { desc = "Delete all marks in buffer" } },
  },
  config = function()
    require("marks").setup()
  end,
}
