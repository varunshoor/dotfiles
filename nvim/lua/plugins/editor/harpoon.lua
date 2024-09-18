-- Better Marks
-- This has been tightly integrated with Kitty.
-- Use Cmd + [ ] to navigate between buffers.
-- Use Cmd + a to add a new buffer.
-- Use Cmd + 1 2 3 4 to navigate to the first four buffers.
-- See: https://github.com/ThePrimeagen/harpoon

return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()

    local special_escape_leader = "<Char-0xff>"

    vim.keymap.set({ "n", "i" }, special_escape_leader .. "a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set({ "n", "i" }, special_escape_leader .. "1", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set({ "n", "i" }, special_escape_leader .. "2", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set({ "n", "i" }, special_escape_leader .. "3", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set({ "n", "i" }, special_escape_leader .. "4", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set({ "n", "i" }, special_escape_leader .. "]", function()
      harpoon:list():prev()
    end)
    vim.keymap.set({ "n", "i" }, special_escape_leader .. "[", function()
      harpoon:list():next()
    end)

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", ";h", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
