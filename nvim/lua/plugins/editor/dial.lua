-- Extended increment/decrement plugin

return {
  "monaqa/dial.nvim",
  lazy = true,
  config = function()
    local augend = require("dial.augend")

    local function add_constant(elements, isWord)
      return augend.constant.new({
        elements = elements,
        cyclic = true,
        word = isWord,
      })
    end

    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        augend.semver.alias.semver,
        add_constant({ "and", "or" }, true),
        add_constant({ "&&", "||" }, false),
        add_constant({ "TRUE", "FALSE" }, true),
        add_constant({ "private", "public" }, true),
      },
      js = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        augend.semver.alias.semver,
        add_constant({ "and", "or" }, true),
        add_constant({ "&&", "||" }, false),
        add_constant({ "TRUE", "FALSE" }, true),
        add_constant({ "private", "public" }, true),
        add_constant({ "const", "let" }, true),
      },
      go = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        augend.semver.alias.semver,
        add_constant({ "and", "or" }, true),
        add_constant({ "&&", "||" }, false),
        add_constant({ "TRUE", "FALSE" }, true),
        add_constant({ "var", "const" }, true),
      },
      lua = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        augend.semver.alias.semver,
        add_constant({ "and", "or" }, true),
        add_constant({ "&&", "||" }, false),
        add_constant({ "TRUE", "FALSE" }, true),
        add_constant({ "private", "public" }, true),
      },
    })

    -- vim.keymap.set("n", "-", require("dial.map").dec_normal())
    -- vim.keymap.set("n", "+", require("dial.map").inc_normal())
    vim.keymap.set("v", "-", require("dial.map").dec_visual())
    vim.keymap.set("v", "+", require("dial.map").inc_visual())

    local wkl = require("which-key")

    vim.cmd("autocmd FileType go lua WhichKeyGo()")
    vim.cmd("autocmd FileType javascript lua WhichKeyJS()")
    vim.cmd("autocmd FileType typescript lua WhichKeyJS()")
    vim.cmd("autocmd FileType lua lua WhichKeyLua()")
    function WhichKeyGo()
      wkl.register({
        ["+"] = { require("dial.map").inc_normal("go"), "increment" },
        ["-"] = { require("dial.map").dec_normal("go"), "decrement" },
      })
    end
    function WhichKeyJS()
      wkl.register({
        ["+"] = { require("dial.map").inc_normal("js"), "increment" },
        ["-"] = { require("dial.map").dec_normal("js"), "decrement" },
      })
    end
    function WhichKeyLua()
      wkl.register({
        ["+"] = { require("dial.map").inc_normal("lua"), "increment" },
        ["-"] = { require("dial.map").dec_normal("lua"), "decrement" },
      })
    end
  end,
}
