-- Smart, seamless, directional navigation and resizing of
-- Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty.

return {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
  config = function()
    require("smart-splits").setup({})

    -- vim.keymap.set("n", "<C-w><", require("smart-splits").resize_left)
    -- vim.keymap.set("n", "<C-w>-", require("smart-splits").resize_down)
    -- vim.keymap.set("n", "<C-w>=", require("smart-splits").resize_up)
    -- vim.keymap.set("n", "<C-w>>", require("smart-splits").resize_right)
  end,
}
