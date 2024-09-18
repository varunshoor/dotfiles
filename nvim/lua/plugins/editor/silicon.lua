-- Take Screenshots and Place them in Clipboard
-- See: https://github.com/michaelrommel/nvim-silicon

return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  keys = {
    {
      "<leader>ss",
      function()
        require("nvim-silicon").clip()
      end,
      mode = { "n", "v" },
      desc = "Take Screenshot",
    },
  },
  config = function()
    require("silicon").setup({
      font = "BerkeleyMono Nerd Font Mono=20;JetBrainsMono Nerd Font=20",
      theme = "GitHub",
      to_clipboard = true,
    })
  end,
}
