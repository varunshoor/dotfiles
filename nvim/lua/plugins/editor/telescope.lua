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
  },
  keys = {
    { ";b", LazyVim.pick("buffers", { sort_mru = true }), desc = "Switch Buffer" },
    {
      ";g",
      LazyVim.pick("live_grep", {
        additional_args = function(opts)
          return { "--hidden" }
        end,
        cwd = false,
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
    { ";'", "<cmd>Telescope resume<cr>", desc = "Resume" },

    -- git
    { ";Rc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { ";Rs", "<cmd>Telescope git_status<CR>", desc = "status" },
    { ";Rr", "<cmd>Telescope repo list<CR>", desc = "show repo list across home directory" },

    -- References
    { ";r", "<cmd>Telescope lsp_references<cr>", desc = "References" },

    -- Symbols
    { ";s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { ";S", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },

    -- projects
    { ";p", "<cmd>Telescope project<cr>", desc = "Display project listing" },

    -- Tabs
    { ";t", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Tabs" },

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

    vim.keymap.set("n", ";<space>", function()
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
      })
    end)
  end,
}
