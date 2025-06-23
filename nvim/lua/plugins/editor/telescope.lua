local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local open_with_trouble = require("trouble.sources.telescope").open

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "LukasPietzschmann/telescope-tabs", config = true },
    { "nvim-telescope/telescope-project.nvim" },
    { "cljoly/telescope-repo.nvim" },
    { "jemag/telescope-diff.nvim" },
    { "albenisolmos/telescope-oil.nvim" },
  },
  keys = {
    { ";b", LazyVim.pick("buffers", { sort_mru = true }), desc = "Switch Buffer" },
    {
      ";g",
      LazyVim.pick("live_grep", {
        additional_args = function(opts)
          return { "--hidden" }
        end,
        cwd = vim.fn.getcwd(),
      }),
      desc = "Find in Files (Grep)",
    },
    {
      ";G",
      function()
        require("telescope.builtin").live_grep({
          cwd = vim.fn.expand("%:p:h"), -- Use the directory of the current file
        })
      end,
      desc = "Find in Files (Grep) in current file's directory",
    },
    { ";w", LazyVim.pick("grep_string"), desc = "Word (root dir)" },
    {
      ";W",
      function()
        require("telescope.builtin").grep_string({
          cwd = vim.fn.expand("%:p:h"), -- Use the directory of the current file
          search = vim.fn.expand("<cword>"),
        })
      end,
      desc = "Word under cursor (current file's dir)",
    },
    {
      ";f",
      function()
        require("telescope.builtin").find_files({
          -- no_ignore = true, -- Display git ignored files if set to true
          -- hidden = true,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
            "--glob",
            "!dist/*",
            "--glob",
            "!**/coverage/*",
          },

          cwd = false,
        })
      end,
      desc = "Find Files (root dir)",
    },
    { ";F", LazyVim.pick("files", { no_ignore = true, hidden = true }), desc = "Find Files (CWD dir)" },
    { ";l", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    { ";h", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { ";a", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer Fuzzy Find" },
    { ";k", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { ";e", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { ";C", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { ";cc", "<cmd>Telescope neoclip<cr>", desc = "Clipboard History" },
    { ";co", "<cmd>Telescope git_bcommits<cr>", desc = "Git Commits" },
    { ";cs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },

    -- Marks
    { ";m", "<cmd>Telescope marks<cr>", desc = "Marks" },

    -- Diff
    {
      ";d",
      function()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        require("telescope.builtin").find_files({
          prompt_title = "Select Directory for Diff",
          cwd = vim.fn.expand("~"),
          hidden = true,
          find_command = { "fd", "--type", "d", "--exclude", ".*", "--max-depth", "3", "." },
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                local selected_dir = vim.fn.expand("~") .. "/" .. selection[1]
                -- Now use the selected directory for diff
                require("telescope").extensions.diff.diff_current({
                  cwd = selected_dir,
                })
              end
            end)
            return true
          end,
        })
      end,
      desc = "Compare file outside of project",
    },

    {
      ";D",
      function()
        local project_root = vim.fn.getcwd()
        require("telescope").extensions.diff.diff_current({
          hidden = true,
          cwd = project_root,
        })
      end,
      desc = "Compare current file",
    },

    -- Resume
    { ";<space>", "<cmd>Telescope resume<cr>", desc = "Resume" },

    -- Notifications
    { ";n", "<cmd>Telescope notify<cr>", desc = "Notifications" },

    -- git
    { ";Rc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { ";Rs", "<cmd>Telescope git_status<CR>", desc = "status" },
    { ";Rr", "<cmd>Telescope repo list<CR>", desc = "show repo list across home directory" },

    -- References
    { ";r", "<cmd>Telescope lsp_references<cr>", desc = "References" },

    -- Symbols
    { ";s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    {
      ";S",
      function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local utils = require("telescope.utils")
        local entry_display = require("telescope.pickers.entry_display")

        -- LSP symbol type highlights (following Telescope's pattern)
        local lsp_type_highlight = {
          File = "TelescopeResultsConstant",
          Module = "TelescopeResultsConstant",
          Namespace = "TelescopeResultsConstant",
          Package = "TelescopeResultsConstant",
          Class = "TelescopeResultsFunction",
          Method = "TelescopeResultsMethod",
          Property = "TelescopeResultsVariable",
          Field = "TelescopeResultsVariable",
          Constructor = "TelescopeResultsFunction",
          Enum = "TelescopeResultsConstant",
          Interface = "TelescopeResultsConstant",
          Function = "TelescopeResultsFunction",
          Variable = "TelescopeResultsVariable",
          Constant = "TelescopeResultsConstant",
          String = "TelescopeResultsString",
          Number = "TelescopeResultsNumber",
          Boolean = "TelescopeResultsConstant",
          Array = "TelescopeResultsConstant",
          Object = "TelescopeResultsConstant",
          Key = "TelescopeResultsVariable",
          Null = "TelescopeResultsConstant",
          EnumMember = "TelescopeResultsConstant",
          Struct = "TelescopeResultsConstant",
          Event = "TelescopeResultsConstant",
          Operator = "TelescopeResultsOperator",
          TypeParameter = "TelescopeResultsConstant",
        }

        -- Function to get symbols from a buffer
        local function get_buffer_symbols(bufnr)
          local params = {
            textDocument = vim.lsp.util.make_text_document_params(bufnr),
          }

          local results = {}
          -- Use vim.lsp.get_clients instead of deprecated get_active_clients
          local clients = vim.lsp.get_clients({ bufnr = bufnr })

          for _, client in pairs(clients) do
            if client.server_capabilities.documentSymbolProvider then
              local response = client.request_sync("textDocument/documentSymbol", params, 5000, bufnr)
              if response and response.result then
                -- Flatten nested symbols (following Telescope's approach)
                local function flatten_symbols(symbols, parent_name)
                  local flattened = {}
                  for _, symbol in ipairs(symbols) do
                    local symbol_name = parent_name and (parent_name .. "." .. symbol.name) or symbol.name
                    table.insert(flattened, {
                      symbol = symbol,
                      bufnr = bufnr,
                      filename = vim.api.nvim_buf_get_name(bufnr),
                      symbol_name = symbol_name,
                    })

                    -- Recursively flatten children
                    if symbol.children then
                      local children = flatten_symbols(symbol.children, symbol_name)
                      for _, child in ipairs(children) do
                        table.insert(flattened, child)
                      end
                    end
                  end
                  return flattened
                end

                local flattened = flatten_symbols(response.result)
                for _, item in ipairs(flattened) do
                  table.insert(results, item)
                end
              end
            end
          end

          return results
        end

        -- Get all visible buffers
        local visible_buffers = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
            visible_buffers[buf] = true
          end
        end

        -- Collect symbols from all visible buffers
        local all_symbols = {}
        for bufnr, _ in pairs(visible_buffers) do
          local symbols = get_buffer_symbols(bufnr)
          for _, item in ipairs(symbols) do
            table.insert(all_symbols, item)
          end
        end

        -- Create displayer (following Telescope's pattern)
        local displayer = entry_display.create({
          separator = " ",
          hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
          items = {
            { width = 25 }, -- symbol name
            { width = 10 }, -- symbol type
            { remaining = true }, -- filename
          },
        })

        -- Entry maker function (following Telescope's pattern)
        local function make_entry(entry)
          local symbol = entry.symbol
          local filename = vim.fn.fnamemodify(entry.filename, ":t")
          local symbol_type = symbol.kind and vim.lsp.protocol.SymbolKind[symbol.kind] or "Unknown"

          local make_display = function()
            return displayer({
              entry.symbol_name,
              { "[" .. symbol_type:lower() .. "]", lsp_type_highlight[symbol_type] or "TelescopeResultsComment" },
              { filename, "TelescopeResultsIdentifier" },
            })
          end

          return {
            value = entry,
            display = make_display,
            ordinal = entry.symbol_name .. " " .. symbol_type .. " " .. filename,
            filename = entry.filename,
            lnum = symbol.location and symbol.location.range.start.line + 1
              or (symbol.range and symbol.range.start.line + 1 or 1),
            col = symbol.location and symbol.location.range.start.character + 1
              or (symbol.range and symbol.range.start.character + 1 or 1),
            symbol_name = entry.symbol_name,
            symbol_type = symbol_type,
          }
        end

        -- Create telescope picker
        pickers
          .new({}, {
            prompt_title = "LSP Symbols (Visible Buffers)",
            finder = finders.new_table({
              results = all_symbols,
              entry_maker = make_entry,
            }),
            sorter = conf.generic_sorter({}),
            previewer = conf.grep_previewer({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.cmd("edit " .. selection.filename)
                  vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
                end
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "Symbols from Visible Buffers",
    },
    { ";SW", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },

    -- projects
    { ";p", "<cmd>Telescope project<cr>", desc = "Display project listing" },

    -- Tabs
    { ";t", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Tabs" },

    -- Oil
    { ";o", "<cmd>Telescope oil<cr>", desc = "Oil" },

    -- todo
    { ";x", "<cmd>TodoTelescope<cr>", desc = "Todo" },

    -- harpoon
    { ";h", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon" },
  },
  opts = function()
    return {
      pickers = {
        ignore_current_buffer = true,
        sort_lastused = true,
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              ["a"] = require("telescope").extensions.file_browser.actions.create,
              ["A"] = require("telescope").extensions.file_browser.actions.create,
              ["<"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
              ["<space>"] = require("telescope").extensions.file_browser.actions.goto_cwd,
            },
          },
        },

        project = {
          base_dirs = {
            "~/dev/",
            "~/bottomline/",
            "~/orgpedia/",
          },
          hidden_files = true, -- default: false
          theme = "dropdown",
        },

        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },

      defaults = {
        file_ignore_patterns = { "^.git/(.*)", "node_modules/*" },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close, -- Close directly on Esc vs entering normal mode
            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
            ["<C-t>"] = open_with_trouble,
            ["<C-d>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["<esc>"] = require("telescope.actions").close, -- Close directly on Esc vs entering normal mode
            ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
            ["<C-t>"] = open_with_trouble,
            ["<C-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("project")
    telescope.load_extension("repo")
    telescope.load_extension("diff")
    telescope.load_extension("harpoon")
    telescope.load_extension("oil")
    telescope.load_extension("notify")
  end,
}
