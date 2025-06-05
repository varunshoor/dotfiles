local function getFortune()
  local info = {}
  local fortune = require("fortune")
  fortune.setup({
    content_type = "tips",
  })

  local fortuneTxt = fortune.get_fortune()
  local footer = vim.list_extend(info, fortuneTxt)
  return footer
end

local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
local headerStr = [[
██████╗░░█████╗░████████╗████████╗░█████╗░███╗░░░███╗██╗░░░░░██╗███╗░░██╗███████╗
██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██╔══██╗████╗░████║██║░░░░░██║████╗░██║██╔════╝
██████╦╝██║░░██║░░░██║░░░░░░██║░░░██║░░██║██╔████╔██║██║░░░░░██║██╔██╗██║█████╗░░
██╔══██╗██║░░██║░░░██║░░░░░░██║░░░██║░░██║██║╚██╔╝██║██║░░░░░██║██║╚████║██╔══╝░░
██████╦╝╚█████╔╝░░░██║░░░░░░██║░░░╚█████╔╝██║░╚═╝░██║███████╗██║██║░╚███║███████╗
╚═════╝░░╚════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚═╝╚═╝░░╚══╝╚══════╝

]] .. cwd .. [[

]] .. table.concat(getFortune(), "\n")

return {
  "snacks.nvim",
  keys = {
    { "<leader>n", false },
  },
  opts = {
    notifier = { enabled = false },
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = headerStr,
       -- stylua: ignore
       ---@type snacks.dashboard.Item[]
       keys = {
         { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
         { icon = "󰪶 ", key = "y", desc = "Explore Files", action = ":Yazi toggle" },
         { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
         { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
         { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
         { icon = " ", key = "q", desc = "Quit", action = ":qa" },
       },
      },
    },
  },
}
