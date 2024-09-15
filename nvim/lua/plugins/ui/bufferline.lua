return {
  "akinsho/bufferline.nvim",
  opts = {
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
