return {
  "mason-org/mason.nvim",
  keys = { { "<leader>ma", "<cmd>Mason<cr>", desc = "Mason" } },
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "taplo",
    },
  },
}
