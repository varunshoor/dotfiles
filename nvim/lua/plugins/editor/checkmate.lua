-- A Markdown-based todo list plugin for Neovim with a nice UI and full customization options.
-- See: https://github.com/bngarren/checkmate.nvim

return {
  "bngarren/checkmate.nvim",
  ft = "markdown,md", -- Lazy loads for Markdown files matching patterns in 'files'
  opts = {
    files = { "*.md", "*.markdown" },
  },
}
