-- Smart, seamless, directional navigation and resizing of
-- Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty.

return {
  "mrjones2014/smart-splits.nvim",
  version = "=2.0.4",
  build = "./kitty/install-kittens.bash",
  keys = {
    -- Reset the existing keymap to nothing
    { "<C-Left>", "<Plug>SmartSplitLeft", mode = { "n" }, desc = "Move cursor left" },
    { "<C-Down>", "<Plug>SmartSplitDown", mode = { "n" }, desc = "Move cursor down" },
    { "<C-Up>", "<Plug>SmartSplitUp", mode = { "n" }, desc = "Move cursor up" },
    { "<C-Right>", "<Plug>SmartSplitRight", mode = { "n" }, desc = "Move cursor right" },
    { "<C-S-Left>", "<Plug>SmartSplitResizeLeft", mode = { "n" }, desc = "Resize left" },
    { "<C-S-Down>", "<Plug>SmartSplitResizeDown", mode = { "n" }, desc = "Resize down" },
    { "<C-S-Up>", "<Plug>SmartSplitResizeUp", mode = { "n" }, desc = "Resize up" },
    { "<C-S-Right>", "<Plug>SmartSplitResizeRight", mode = { "n" }, desc = "Resize right" },

    { "<C-h>", "<Plug>SmartSplitLeft", mode = { "n" }, desc = "Move cursor left" },
    { "<C-j>", "<Plug>SmartSplitDown", mode = { "n" }, desc = "Move cursor down" },
    { "<C-k>", "<Plug>SmartSplitUp", mode = { "n" }, desc = "Move cursor up" },
    { "<C-l>", "<Plug>SmartSplitRight", mode = { "n" }, desc = "Move cursor right" },
    { "<C-S-h>", "<Plug>SmartSplitResizeLeft", mode = { "n" }, desc = "Resize left" },
    { "<C-S-j>", "<Plug>SmartSplitResizeDown", mode = { "n" }, desc = "Resize down" },
    { "<C-S-k>", "<Plug>SmartSplitResizeUp", mode = { "n" }, desc = "Resize up" },
    { "<C-S-l>", "<Plug>SmartSplitResizeRight", mode = { "n" }, desc = "Resize right" },
  },
  config = function()
    local smart_splits = require("smart-splits")
    smart_splits.setup({})

    -- moving between splits
    vim.keymap.set("n", "<C-Left>", smart_splits.move_cursor_left, { silent = true })
    vim.keymap.set("n", "<C-Down>", smart_splits.move_cursor_down, { silent = true })
    vim.keymap.set("n", "<C-Up>", smart_splits.move_cursor_up, { silent = true })
    vim.keymap.set("n", "<C-Right>", smart_splits.move_cursor_right, { silent = true })

    -- smart resize
    vim.keymap.set("n", "<C-S-Left>", smart_splits.resize_left, { silent = true })
    vim.keymap.set("n", "<C-S-Down>", smart_splits.resize_down, { silent = true })
    vim.keymap.set("n", "<C-S-Up>", smart_splits.resize_up, { silent = true })
    vim.keymap.set("n", "<C-S-Right>", smart_splits.resize_right, { silent = true })

    -- moving between splits
    vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { silent = true })
    vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { silent = true })
    vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { silent = true })
    vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { silent = true })

    -- smart resize
    vim.keymap.set("n", "<C-S-h>", smart_splits.resize_left, { silent = true })
    vim.keymap.set("n", "<C-S-j>", smart_splits.resize_down, { silent = true })
    vim.keymap.set("n", "<C-S-k>", smart_splits.resize_up, { silent = true })
    vim.keymap.set("n", "<C-S-l>", smart_splits.resize_right, { silent = true })
  end,
}
