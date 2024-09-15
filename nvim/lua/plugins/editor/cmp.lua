-- Intellisense and autocomplete

return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp-signature-help", -- Shows function documentation once you begin typing signature
  },
  opts = function()
    local cmp = require("cmp")

    local lspkind = require("lspkind")

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<PageUp>"] = function(fallback)
          if cmp.visible() then
            for _ = 1, 10 do
              cmp.mapping.select_prev_item()(nil)
            end
          else
            fallback()
          end
        end,
        ["<PageDown>"] = function(fallback)
          if cmp.visible() then
            for _ = 1, 10 do
              cmp.mapping.select_next_item()(nil)
            end
          else
            fallback()
          end
        end,

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.expandable() then
            luasnip.expand()
          -- elseif luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),
      sources = cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "supermaven" },
        -- { name = "path" }, -- Not worth it as it seems to trigger unnecessary auto complete
      }),
      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          maxwidth = 50,
          before = function(_, vim_item)
            return vim_item
          end,
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
            buffer = "[Buffer]",
            look = "[Dict]",
            calc = "[Calc]",
            treesitter = "[Treesitter]",
          },
        }),
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    }
  end,
}
