return {}

-- Breaks because of tree sitter changes and dependency on ts_utils, restore when fixed
-- return {
--   "rafaelsq/nvim-goc.lua",
--   event = "VeryLazy",
--   config = function()
--     local goc = require("nvim-goc")
--     goc.setup({ verticalSplit = false })
--
--     vim.keymap.set("n", "<Leader>gcf", goc.Coverage, { silent = true }) -- run for the whole File
--     vim.keymap.set("n", "<Leader>gct", goc.CoverageFunc, { silent = true }) -- run only for a specific Test unit
--     vim.keymap.set("n", "<Leader>gcc", goc.ClearCoverage, { silent = true }) -- clear coverage highlights
--   end,
-- }
