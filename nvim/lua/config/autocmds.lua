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

-- Close term windows using Esc
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*yazi*",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "q", { noremap = true })
  end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en"
  end,
})

vim.g.is_closing_buffer = false

-- Function to check if a filename is a test file
local function is_test_file(filename)
  return filename:find("spec") or filename:find("test")
end

-- Function to find a window with test or spec file
local function find_test_window()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local full_bufname = vim.api.nvim_buf_get_name(buf)
    local bufname = vim.fn.fnamemodify(full_bufname, ":t")

    if is_test_file(bufname) then
      return win
    end
  end
  return nil
end

-- Function to find a window with a specific file
local function find_window_with_file(target_file, ignore_win)
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    -- Skip the window we want to ignore
    if ignore_win and win == ignore_win then
      goto continue
    end

    local buf = vim.api.nvim_win_get_buf(win)
    local full_bufname = vim.api.nvim_buf_get_name(buf)

    if full_bufname == target_file then
      return win
    end

    ::continue::
  end
  return nil
end

-- Function to get potential test files for a given source file
local function get_test_files(path, filename, extension)
  local testfiles = {}
  local hasTestFiles = false

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

  return testfiles, hasTestFiles
end

-- Function to get parent file from test file
local function get_parent_file_from_test(current_file)
  local path = vim.fn.expand("%:p:h") .. "/"
  local filename = vim.fn.expand("%:t:r")
  local extension = vim.fn.expand("%:e")

  -- Strip test/spec suffixes from filename
  local parent_filename = filename
  if filename:match("_test$") then
    parent_filename = filename:gsub("_test$", "")
  elseif filename:match("%.test$") then
    parent_filename = filename:gsub("%.test$", "")
  elseif filename:match("%.spec$") then
    parent_filename = filename:gsub("%.spec$", "")
  end

  local parent_files = {}

  if extension == "go" then
    table.insert(parent_files, path .. parent_filename .. ".go")
  elseif extension == "ts" or extension == "tsx" then
    -- Convert test path back to src path
    local srcpath = path:gsub("/tests/", "/src/")
    table.insert(parent_files, srcpath .. parent_filename .. ".ts")
    if extension == "tsx" then
      table.insert(parent_files, srcpath .. parent_filename .. ".tsx")
    end
  end

  return parent_files
end

-- Function to set keymaps based on filetype
local function set_dial_keymaps(filetype)
  local group = filetype or "default"
  vim.keymap.set("n", "+", require("dial.map").inc_normal(group), { buffer = true })
  vim.keymap.set("n", "-", require("dial.map").dec_normal(group), { buffer = true })
  vim.keymap.set("v", "+", require("dial.map").inc_visual(group), { buffer = true })
  vim.keymap.set("v", "-", require("dial.map").dec_visual(group), { buffer = true })
end

-- Set up autocommands for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "javascript", "typescript", "lua" },
  callback = function(opts)
    set_dial_keymaps(opts.match)
  end,
})

-- Set up default keymaps for other filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if not vim.tbl_contains({ "go", "javascript", "typescript", "lua" }, vim.bo.filetype) then
      set_dial_keymaps()
    end
  end,
})

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

    if is_test_file(orig_bufname) then
      if orig_winnum == 3 then
        vim.g.is_closing_buffer = true
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.go", "*.ts", "*.tsx" },
  callback = function()
    local current_file = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r")

    -- Only proceed if current buffer is a test file
    if not is_test_file(filename) then
      return
    end

    -- Get potential parent files for this test file
    local parent_files = get_parent_file_from_test(current_file)

    -- Check if any parent file has an open window
    for _, parent_file in ipairs(parent_files) do
      if vim.fn.filereadable(parent_file) == 1 then
        local parent_win = find_window_with_file(parent_file)
        if parent_win then
          vim.api.nvim_win_close(parent_win, false)
          break
        end
      end
    end
  end,
})

-- Global variable to track if we're already processing a file navigation
vim.g.processing_file_navigation = false

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*", "*" },
  callback = function()
    -- Prevent duplicate execution
    if vim.g.processing_file_navigation then
      return
    end

    if vim.g.is_closing_buffer then
      vim.g.is_closing_buffer = false
      return
    end

    -- Skip if current window is a floating window
    local win_config = vim.api.nvim_win_get_config(0)
    if win_config.relative ~= "" then
      return
    end

    -- Skip if current buffer is not a file buffer
    local buftype = vim.bo.buftype
    if buftype ~= "" then
      return
    end

    vim.g.processing_file_navigation = true

    local path = vim.fn.expand("%:p:h") .. "/"
    local filename = vim.fn.expand("%:t:r")
    local extension = vim.fn.expand("%:e")

    -- require("notify")("Processing file navigation for: " .. filename, "info", { title = "File Navigation" })
    local parent_win = nil

    local isTestFile = is_test_file(filename)

    -- Handle entering a test buffer - load the main file if not already open
    if isTestFile then
      local current_file = vim.fn.expand("%:p")
      local parent_files = get_parent_file_from_test(current_file)
      local orig_win = vim.api.nvim_get_current_win()

      -- First, close any existing test windows that don't match the current test file
      local windows = vim.api.nvim_list_wins()
      for _, win in ipairs(windows) do
        if win ~= orig_win then
          local buf = vim.api.nvim_win_get_buf(win)
          local full_bufname = vim.api.nvim_buf_get_name(buf)
          local bufname = vim.fn.fnamemodify(full_bufname, ":t")

          if is_test_file(bufname) then
            -- require("notify")("Closing unrelated test file: " .. bufname, "info", { title = "File Navigation" })
            vim.api.nvim_win_close(win, false)
          end
        end
      end

      -- Look for a window that already has one of the parent files
      local found_parent_file = nil

      for _, parent_file in ipairs(parent_files) do
        if vim.fn.filereadable(parent_file) == 1 then
          parent_win = find_window_with_file(parent_file)
          if parent_win then
            found_parent_file = parent_file
            break
          end
          -- If no window found but file exists, use the first existing parent file
          if not found_parent_file then
            found_parent_file = parent_file
          end
        end
      end

      -- If we found a parent file but no window is open with it, open it as a regular buffer
      if found_parent_file and not parent_win then
        -- Schedule the file opening to happen after the current autocmd finishes
        vim.schedule(function()
          -- Create a split to the left of the current window
          -- require("notify")("Opening parent file: " .. found_parent_file, "info", { title = "Test File Navigation" })
          vim.cmd("leftabove vsplit")
          parent_win = vim.api.nvim_get_current_win()

          -- Load the parent file in the new window
          vim.api.nvim_win_set_buf(parent_win, vim.fn.bufadd(found_parent_file))

          -- Set the correct filetype
          local file_ext = found_parent_file:match("^.+(%..+)$")
          local filetype = "go" -- default filetype
          if file_ext == ".ts" or file_ext == ".tsx" then
            filetype = "typescript"
          elseif file_ext == ".js" or file_ext == ".jsx" then
            filetype = "javascript"
          end
          vim.bo[vim.api.nvim_win_get_buf(parent_win)].filetype = filetype

          -- Return focus to the original test window
          vim.api.nvim_set_current_win(orig_win)

          -- Reset the flag after a brief delay
          vim.defer_fn(function()
            vim.g.processing_file_navigation = false
          end, 100)
        end)
      else
        vim.g.processing_file_navigation = false
      end
      return
    else
      local parent_file = vim.fn.expand("%:p")
      parent_win = find_window_with_file(parent_file, vim.api.nvim_get_current_win())
    end

    local testfiles, hasTestFiles = get_test_files(path, filename, extension)
    local orig_win = vim.api.nvim_get_current_win()
    local target_win = find_test_window()

    -- Open the first existing test file
    if hasTestFiles then
      local foundTestFile = false

      for _, testfile in pairs(testfiles) do
        -- Check if this test file is already open in the target window
        if target_win then
          local target_buf = vim.api.nvim_win_get_buf(target_win)
          local target_bufname = vim.api.nvim_buf_get_name(target_buf)
          if target_bufname == testfile then
            foundTestFile = true

            -- require("notify")(
            --   "Test file already open: " .. vim.fn.fnamemodify(testfile, ":t"),
            --   "info",
            --   { title = "Test File Navigation" }
            -- )
            break
          end
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
            -- require("notify")(
            --   "Opened test file: " .. vim.fn.fnamemodify(testfile, ":t"),
            --   "info",
            --   { title = "Test File Navigation" }
            -- )

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

        -- require("notify")("No test files found for: " .. filename, "info", { title = "Test File Navigation" })
      end

      if foundTestFile then
        vim.api.nvim_set_current_win(orig_win)

        -- We have set the target to current window, so if its a non test file,
        -- it will open in current window and then open a split for a test file
        -- If we already have an existing parent window, we need to close it
        if not isTestFile and parent_win then
          vim.api.nvim_win_close(parent_win, false)
        end

        -- require("notify")(
        --   "Test file already exists.. setting target window to original window: "
        --     .. vim.fn.fnamemodify(testfiles[1], ":t"),
        --   "info",
        --   { title = "Test File Navigation" }
        -- )
      end
    else
      -- We don't have any test files, check if we have an existing window with test case
      -- If we do, that means its a relic of an old file that needs to be closed
      -- This is scoped to the main window to prevent popups from closing test windows
      if target_win then
        vim.api.nvim_win_close(target_win, false)

        -- require("notify")(
        --   "No test files found for, closing test split: " .. filename,
        --   "info",
        --   { title = "Test File Navigation" }
        -- )
      end
    end

    vim.g.processing_file_navigation = false
  end,
})

-- Change filetype of .envrc to dotenv
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".envrc" },
  callback = function()
    vim.bo.filetype = "dotenv"
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env" },
  callback = function()
    vim.bo.filetype = "env"
  end,
})

-- Makefiles require actual tabs
vim.cmd("au FileType make setlocal noexpandtab")

-- Golang files require actual tabs
vim.cmd("au FileType go setlocal noexpandtab")
