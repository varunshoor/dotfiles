-- See: https://github.com/mfussenegger/nvim-lint
-- Q: Why does this exist?
-- TODO: Find out

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", "~/.config/.markdownlint-cli2.yml", "--" },
        },
      },
    },
  },
}
