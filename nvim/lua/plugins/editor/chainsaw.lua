-- Smart and highly customizable insertion of various kinds of log statements.

return {
  "chrisgrieser/nvim-chainsaw",
  event = "VeryLazy",
  opts = {}, -- required even if left empty
  keys = {
    {
      "L",
      function()
        require("chainsaw").variableLog()
      end,
      desc = "Chainsaw",
    },
  },
}
