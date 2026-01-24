-- REST client with automatic JSON response formatting using jq
-- Extends LazyVim's rest extra (lazyvim.plugins.extras.util.rest)
-- Requires: jq (brew install jq)
-- See: https://github.com/mistweaverco/kulala.nvim

return {
  "mistweaverco/kulala.nvim",
  opts = {
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = vim.fn.executable("jq") == 1 and { "jq", "--indent", "4", "." } or nil,
        pathresolver = function(...)
          return require("kulala.parser.jsonpath").parse(...)
        end,
      },
    },
  },
}
