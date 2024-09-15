return {
  "akinsho/bufferline.nvim",
  opts = {
    highlights = {
      buffer_selected = { italic = false },
      diagnostic_selected = { italic = false },
      hint_selected = { italic = false },
      pick_selected = { italic = false },
      pick_visible = { italic = false },
      pick = { italic = false },
    },
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true, -- By default bufferline is not displayed if there is only one file
      -- separator_style = "slant",
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
