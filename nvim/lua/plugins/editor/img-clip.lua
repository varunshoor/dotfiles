-- Dependency used by avante.nvim
-- Added to disable annoying notifications
return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    verbose = false, -- Disables annoying notifications
  },
}
