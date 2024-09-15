return {
  "jackMort/ChatGPT.nvim",
  enabled = false,
  lazy = true,
  event = "VeryLazy",
  opts = {
    edit_with_instructions = {
      keymaps = {
        close = "<Esc>",
      },
    },
    chat = {
      keymaps = {
        close = "<Esc>",
      },
    },
    popup_input = {
      submit = "<Enter>",
    },
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)

    vim.keymap.set("n", "<leader>ac", "<cmd>ChatGPT<cr>")
    vim.keymap.set("n", "<leader>ai", "<cmd>ChatGPTEditWithInstructions<cr>")
    vim.keymap.set("n", "<leader>as", "<cmd>ChatGPTRun summarize<cr>")
    vim.keymap.set("n", "<leader>at", "<cmd>ChatGPTRun add_tests<cr>")
    vim.keymap.set("n", "<leader>ab", "<cmd>ChatGPTRun fix_bugs<cr>")
    vim.keymap.set("n", "<leader>ae", "<cmd>ChatGPTRun explain_code<cr>")
    vim.keymap.set("n", "<leader>ao", "<cmd>ChatGPTRun optimize_code<cr>")
    vim.keymap.set("n", "<leader>ar", "<cmd>ChatGPTRun code_readability_analysis<cr>")

    vim.keymap.set("v", "<leader>ac", "<cmd>ChatGPT<cr>")
    vim.keymap.set("v", "<leader>ai", "<cmd>ChatGPTEditWithInstructions<cr>")
    vim.keymap.set("v", "<leader>as", "<cmd>ChatGPTRun summarize<cr>")
    vim.keymap.set("v", "<leader>at", "<cmd>ChatGPTRun add_tests<cr>")
    vim.keymap.set("v", "<leader>ab", "<cmd>ChatGPTRun fix_bugs<cr>")
    vim.keymap.set("v", "<leader>ae", "<cmd>ChatGPTRun explain_code<cr>")
    vim.keymap.set("v", "<leader>ao", "<cmd>ChatGPTRun optimize_code<cr>")
    vim.keymap.set("v", "<leader>ar", "<cmd>ChatGPTRun code_readability_analysis<cr>")
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
