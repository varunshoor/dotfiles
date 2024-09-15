return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  config = function()
    require("marks").setup()

    -- Keybindings
    vim.keymap.set("n", "mm", "<cmd>lua require('marks').set_next()<CR>", { desc = "Set next mark" })
    vim.keymap.set("n", "m;", "<cmd>lua require('marks').toggle()<CR>", { desc = "Toggle mark" })
    vim.keymap.set("n", "mn", "<cmd>lua require('marks').next()<CR>", { desc = "Next mark" })
    vim.keymap.set("n", "mp", "<cmd>lua require('marks').prev()<CR>", { desc = "Previous mark" })
    vim.keymap.set("n", "ml", "<cmd>MarksListAll<CR>", { desc = "List all marks" })
    vim.keymap.set("n", "md", "<cmd>lua require('marks').delete_line()<CR>", { desc = "Delete mark" })
    vim.keymap.set("n", "mD", "<cmd>lua require('marks').delete_buf()<CR>", { desc = "Delete all marks in buffer" })
  end,
}
