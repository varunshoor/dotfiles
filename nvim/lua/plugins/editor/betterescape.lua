-- jj to escape from insert mode without waiting for timeout

return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup()
  end,
}
