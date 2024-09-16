-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"

vim.opt.swapfile = false

-- Don't persist buffer marks
vim.opt.shada = "'0,f0"

-- The line numbers show relative to the cursor position if this isn't set to false
vim.opt.relativenumber = false

local api = vim.api

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

vim.g.is_closing_buffer = false

-- Disable SQL Complete
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "sql",
  callback = function()
    vim.keymap.del("i", "<left>", { buffer = true })
    vim.keymap.del("i", "<right>", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.go", "*.ts", "*.tsx" },
  callback = function()
    local orig_win = vim.api.nvim_get_current_win()
    local orig_winnum = vim.api.nvim_win_get_number(orig_win)
    local orig_buf = vim.api.nvim_win_get_buf(orig_win)
    local orig_bufname = vim.api.nvim_buf_get_name(orig_buf)

    if orig_bufname:find("spec") or orig_bufname:find("test") then
      if orig_winnum == 3 then
        vim.g.is_closing_buffer = true
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.*" },
  callback = function()
    if vim.g.is_closing_buffer then
      vim.g.is_closing_buffer = false
      return
    end

    local path = vim.fn.expand("%:p:h") .. "/"
    local filename = vim.fn.expand("%:t:r")
    local extension = vim.fn.expand("%:e")

    -- We don't do anything if we are entering a test buffer
    if filename:find("spec") or filename:find("test") then
      return
    end

    local testfiles = {}
    local hasTestFiles = false

    -- Define potential test file paths
    if extension == "go" then
      table.insert(testfiles, path .. filename .. "_test.go")
      hasTestFiles = true
    elseif extension == "ts" or extension == "tsx" then
      local testpath = path:gsub("/src/", "/tests/")
      table.insert(testfiles, testpath .. filename .. ".test.ts")
      table.insert(testfiles, testpath .. filename .. ".spec.ts")
      hasTestFiles = true
      if extension == "tsx" then
        table.insert(testfiles, testpath .. filename .. ".test.tsx")
        table.insert(testfiles, testpath .. filename .. ".spec.tsx")
      end
    end

    local orig_win = vim.api.nvim_get_current_win()
    local orig_winnum = vim.api.nvim_win_get_number(orig_win)

    -- local orig_buf = vim.api.nvim_win_get_buf(orig_win)
    -- local orig_bufname = vim.api.nvim_buf_get_name(orig_buf)
    -- require("notify")(orig_bufname)

    local windows = vim.api.nvim_list_wins()
    local target_win = nil

    -- Search for an open window with a test or spec file
    local bufname = ""
    for _, win in ipairs(windows) do
      local buf = vim.api.nvim_win_get_buf(win)
      local full_bufname = vim.api.nvim_buf_get_name(buf)
      bufname = vim.fn.fnamemodify(full_bufname, ":t")

      if bufname:find("spec") or bufname:find("test") then
        target_win = win
        break
      end

      bufname = ""
    end

    -- Open the first existing test file
    if hasTestFiles then
      local foundTestFile = false

      for _, testfile in pairs(testfiles) do
        if bufname == testfile then
          foundTestFile = true
          break
        end

        if vim.fn.filereadable(testfile) == 1 then
          foundTestFile = true
          if target_win then
            vim.api.nvim_set_current_win(target_win)
          else
            vim.cmd("vsplit")
            target_win = vim.api.nvim_get_current_win()
          end

          if target_win then
            vim.api.nvim_win_set_buf(target_win, vim.fn.bufadd(testfile))
            -- Dynamically set the filetype based on the test file's extension
            local file_ext = testfile:match("^.+(%..+)$")
            local filetype = "go" -- default filetype
            if file_ext == ".ts" or file_ext == ".tsx" then
              filetype = "typescript"
            elseif file_ext == ".js" or file_ext == ".jsx" then
              filetype = "javascript"
            end
            vim.bo[vim.api.nvim_win_get_buf(target_win)].filetype = filetype
            break
          end
        end
      end

      -- If we didn't find a test file but had the entries for it,
      -- and we also have a test window open, then we need to close it
      -- it likely will be from an old file that was open earlier
      if not foundTestFile and target_win then
        vim.api.nvim_win_close(target_win, false)
      end

      if foundTestFile then
        vim.api.nvim_set_current_win(orig_win)
      end
    else
      -- We don't have any test files, check if we have an existing window with test case
      -- If we do, that means its a relic of an old file that needs to be closed
      -- This is scoped to the main window to prevent popups from closing test windows
      if target_win and orig_winnum == 2 then
        vim.api.nvim_win_close(target_win, false)
      end
    end
  end,
})

-- Change filetype of .envrc to dotenv
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".envrc" },
  callback = function()
    vim.bo.filetype = "dotenv"
  end,
})

-- Makefiles require actual tabs
vim.cmd("au FileType make setlocal noexpandtab")

-- Golang files require actual tabs
vim.cmd("au FileType go setlocal noexpandtab")
