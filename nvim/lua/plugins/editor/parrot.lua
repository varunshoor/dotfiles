-- https://github.com/frankroeder/dotfiles/blob/master/nvim/lua/plugins/parrot.lua
-- https://github.com/specv/lazyvim/blob/368276e39f84b7610bb5e338c049708199ca53da/lua/plugins/gp.lua#L221
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local hooks = {
  Complete = {
    desc = "Complete the code",
    selection = true,
    fn = function(prt, params)
      local template = [[
        I have the following code from {{filename}}:

        ```{{filetype}}
        {{selection}}
        ```

        Please finish the code above carefully and logically.
        Respond just with the snippet of code that should be inserted no commentary as I intend to replace my code with what you provide in the editor.
        "
        ]]
      local model_obj = prt.get_model("command")
      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
    end,
  },
  CodeConsultant = {
    desc = "Code Consultant",
    selection = false,
    fn = function(prt, params)
      local chat_prompt = [[
          Your task is to analyze the provided {{filetype}} code and suggest
          improvements to optimize its performance. Identify areas where the
          code can be made more efficient, faster, or less resource-intensive.
          Provide specific suggestions for optimization, along with explanations
          of how these changes can enhance the code's performance. The optimized
          code should maintain the same functionality as the original code while
          demonstrating improved efficiency.

          Here is the code
          ```{{filetype}}
          {{filecontent}}
          ```
        ]]
      prt.ChatNew(params, chat_prompt)
    end,
  },
  CompleteFullContext = {
    desc = "Complete the code with full context",
    selection = true,
    fn = function(prt, params)
      local template = [[
        I have the following code from {{filename}}:

				```{{filetype}}
				{filecontent}}
				```

				Please look at the following section specifically:
        ```{{filetype}}
        {{selection}}
        ```

        Please finish the code above carefully and logically.
        Respond just with the snippet of code that should be inserted."
        ]]
      local model_obj = prt.get_model("command")
      prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
    end,
  },
}

function prt_pick_command(mode)
  local command_names = {}
  for name, cmd in pairs(hooks) do
    if mode == "v" or (mode == "n" and not cmd.selection) then
      table.insert(command_names, name .. " - " .. cmd.desc)
    end
  end
  pickers
    .new({}, {
      prompt_title = "Select Command",
      finder = finders.new_table({
        results = command_names,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local command = selection[1]:match("^(%S+)")
          if mode == "v" then
            vim.cmd("normal! gv") -- Reselect the last visual selection
            vim.cmd("Prt" .. command)
          else
            vim.cmd("Prt" .. command)
          end
        end)
        return true
      end,
    })
    :find()
end

return {
  "frankroeder/parrot.nvim",
  dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  config = function()
    local prtHooks = {}
    for name, hook in pairs(hooks) do
      prtHooks[name] = hook.fn
    end

    require("parrot").setup({
      providers = {
        openai = {
          api_key = { "/usr/bin/security", "find-generic-password", "-s openai-api-key", "-w" },
        },
        anthropic = {
          api_key = { "/usr/bin/security", "find-generic-password", "-s anthropic-api-key", "-w" },
        },
      },
      hooks = prtHooks,
      toggle_target = "tabnew",
    })

    vim.keymap.set("n", "<leader>ai", "<cmd>PrtChatToggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>at", "<cmd>PrtChatToggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ax", "<cmd>PrtChatDelete<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>av", ":<C-u>'<,'>PrtChatPaste popup<cr>")
    vim.keymap.set("v", "<leader>ap", ":<C-u>'<,'>PrtChatPaste<cr>")

    vim.keymap.set("n", "<leader>ac", function()
      prt_pick_command("n")
    end, { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>ac", function()
      prt_pick_command("v")
    end, { noremap = true, silent = true })
  end,
}
