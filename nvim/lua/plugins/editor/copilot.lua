-- Github Copilot integration

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

local copilot_filetypes = {}
copilot_filetypes.rust = true
copilot_filetypes.lua = true
copilot_filetypes.python = true
copilot_filetypes.javascript = true
copilot_filetypes.typescript = true
copilot_filetypes.typescriptreact = true
copilot_filetypes.javascriptreact = true
copilot_filetypes.html = true
copilot_filetypes.css = true
copilot_filetypes.scss = true
copilot_filetypes.json = true
copilot_filetypes.yaml = true
copilot_filetypes.toml = true
copilot_filetypes.markdown = false
copilot_filetypes.sh = true
copilot_filetypes.zsh = false
copilot_filetypes.bash = false
copilot_filetypes.dockerfile = true
copilot_filetypes.dotenv = false
vim.g.copilot_filetypes = copilot_filetypes

return {
  "github/copilot.vim",
  lazy = true,
  event = "InsertEnter",
  config = function()
    vim.keymap.set("i", "<Insert>", "copilot#Accept()", { silent = true, expr = true, replace_keycodes = false })
    vim.keymap.set("i", "<F12>", "copilot#Accept()", { silent = true, expr = true, replace_keycodes = false })
    vim.keymap.set("i", "<C-h>", "copilot#Dismiss()", { silent = true, expr = true, replace_keycodes = false })

    vim.keymap.set(
      "i",
      "<C-.>",
      "copilot#Next()",
      { noremap = true, silent = true, expr = true, replace_keycodes = false }
    )
    vim.keymap.set("i", "<C-,>", "copilot#Previous()", { silent = true, expr = true, replace_keycodes = false })
  end,
}
