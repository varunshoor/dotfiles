-- This is a VS Code like winbar that uses nvim-navic in order to get LSP context from your language server.
-- Shows at top showing current context around cursor. Ex: "function_name -> class_name -> file_name"
-- See: https://github.com/utilyre/barbecue.nvim

local spec = {
  "utilyre/barbecue.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
}

function spec.config()
  require("barbecue").setup()
end

return spec
