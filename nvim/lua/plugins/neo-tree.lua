return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      modified = {
        symbol = "●", -- Replace the default [+] with a better modified indicator
        highlight = "NeoTreeModified",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          untracked = "󰈉",
          ignored = "◌",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      position = "left",
      width = 36,
      mappings = {
        ["<space>"] = "noop", -- Switch the focus back to previous window

        ["<Left>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<Right>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "disabled",
    },
  },
}
