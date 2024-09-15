-- Snippet Expansion

return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
  },

  opts = {
    history = true,
    delete_check_events = "TextChanged, TextChangedI",
  },

  config = function(_, opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/vscode" })
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/lua" })

    local luasnip = require("luasnip")
    luasnip.setup(opts)
    luasnip.filetype_extend("javascriptreact", { "html" })
    luasnip.filetype_extend("javascript", { "html", "javascriptreact", "jsdoc" })
    luasnip.filetype_extend("jsx", { "html" })
    luasnip.filetype_extend("typescriptreact", { "html" })
    luasnip.filetype_extend("vue", { "html" })
    luasnip.filetype_extend("php", { "html" })
    luasnip.filetype_extend("typescript", { "typescriptreact", "jsdoc" })
  end,
  keys = function() -- Disable the keys so that cmp takes over
    return {}
  end,
}
