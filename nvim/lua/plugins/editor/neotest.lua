-- An extensible framework for interacting with tests within NeoVim.

return {
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-go" },
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    lazy = true,
    optional = true,
    wants = {
      "plenary.nvim",
      "nvim-treesitter",
      "FixCursorHold.nvim",
      "neotest-plenary",
      "neotest-go",
      "neotest-jest",
    },
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        ["neotest-plenary"] = {},
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
        },
        -- TODO: Jest based tests aren't working, debug
        ["neotest-jest"] = {
          jestCommand = "npm run test --",
          env = { CI = true },
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end
            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          cwd = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
}
