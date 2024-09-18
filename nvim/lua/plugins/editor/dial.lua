-- Extended increment/decrement plugin
-- Does much more than numbers
-- +/- on bool values can toggle them, can also add custom ones below

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
  end,
}
