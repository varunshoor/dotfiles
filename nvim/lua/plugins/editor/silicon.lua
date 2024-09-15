return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  keymaps = {
    { "n", "<leader>ss", ":Silicon<CR>", { noremap = true, silent = true } },
  },
  config = function()
    require("silicon").setup({
      font = "BerkeleyMono Nerd Font Mono=20;JetBrainsMono Nerd Font=20",
      theme = "GitHub",
      to_clipboard = true,
    })
  end,
}
