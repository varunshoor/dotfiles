-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Disable vim recording with q
keymap.set("n", "q", "<Nop>")
keymap.set("v", "q", "<Nop>")

-- Disable arrow keys
-- keymap.set("", "<up>", "<nop>")
-- keymap.set("", "<right>", "<nop>")
-- keymap.set("", "<down>", "<nop>")
-- keymap.set("", "<left>", "<nop>")

-- Save using \w
keymap.set("n", "<leader>w", ":w<cr>")
-- fast save
keymap.set("n", "<Leader><Leader>", ":w<CR>", { noremap = true })

-- [,* ] Search and replace the word under the cursor.
-- all occurrences
vim.keymap.set("n", "<Leader>*", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false })
vim.keymap.set("n", "<Leader>?", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { silent = false })

-- Zoom and Zoom Out like Tmux
if vim.g.zoomed_state == nil then
  vim.g.zoomed_state = false
end

vim.toggle_zoom = function()
  if vim.g.zoomed_state then
    vim.cmd("Neotree action=show toggle=true")
    vim.cmd("wincmd =") -- Reset window size
  else
    vim.cmd("Neotree toggle")
    vim.cmd("wincmd _") -- Maximize window vertically
    vim.cmd("wincmd |") -- Maximize window horizontally
  end
  -- Toggle the zoom state
  vim.g.zoomed_state = not vim.g.zoomed_state
end
keymap.set("n", "<C-w>m", ":lua vim.toggle_zoom()<CR>", { noremap = true, silent = true })

-- Indent and Unindent
keymap.set("i", "<M-,>", "<C-d>", { remap = true })
keymap.set("i", "<M-.>", "<C-t>", { remap = true })

keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- BEGIN KITTY SPECIAL SEQUENCES USING CTRL AND CMD
local special_escape_leader = "<Char-0xff>"

-- Navigate Neovim Tabs Using Ctrl+Tab and Ctrl+Shift+Tab
keymap.set("n", special_escape_leader .. "Tn", "<Cmd>tabn<CR>", { noremap = true, silent = true })
keymap.set("n", special_escape_leader .. "Tp", "<Cmd>tabp<CR>", { noremap = true, silent = true })
keymap.set("i", special_escape_leader .. "Tn", "<Cmd>tabn<CR>", { noremap = true, silent = true })
keymap.set("i", special_escape_leader .. "Tp", "<Cmd>tabp<CR>", { noremap = true, silent = true })
keymap.set("v", special_escape_leader .. "Tn", "<Cmd>tabn<CR>", { noremap = true, silent = true })
keymap.set("v", special_escape_leader .. "Tp", "<Cmd>tabp<CR>", { noremap = true, silent = true })
keymap.set("n", special_escape_leader .. "Tc", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
keymap.set("i", special_escape_leader .. "Tc", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
keymap.set("v", special_escape_leader .. "Tc", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
keymap.set("n", special_escape_leader .. "TN", "<Cmd>$tabnew<CR>", { noremap = true, silent = true })
keymap.set("i", special_escape_leader .. "TN", "<Cmd>$tabnew<CR>", { noremap = true, silent = true })
keymap.set("v", special_escape_leader .. "TN", "<Cmd>$tabnew<CR>", { noremap = true, silent = true })

-- Comment in all modes using Cmd+/
keymap.set({ "i" }, special_escape_leader .. "/", "<ESC>gcci", { remap = true })
keymap.set({ "n" }, special_escape_leader .. "/", "gcc", { remap = true })
keymap.set({ "v" }, special_escape_leader .. "/", "gc", { remap = true })

-- Block Comment in all modes using Cmd+Shift+/
keymap.set({ "i" }, special_escape_leader .. "s/", "<ESC>gbci", { remap = true })
keymap.set({ "n" }, special_escape_leader .. "s/", "gbc", { remap = true })
keymap.set({ "v" }, special_escape_leader .. "s/", "gb", { remap = true })

-- Select All using Cmd+Shift+A
keymap.set("n", special_escape_leader .. "Sa", "ggVG", { remap = true })
keymap.set("i", special_escape_leader .. "Sa", "<ESC>ggVG", { remap = true })

-- Duplicate
keymap.set("n", special_escape_leader .. "d", "yyp", { remap = true })
keymap.set("v", special_escape_leader .. "d", "yp", { remap = true })
keymap.set("i", special_escape_leader .. "d", "<ESC>yypi", { remap = true })

-- in normal mode, press "?" to search for the current word under cursor, but don't jump!
-- this sets the search register "/" to the current word
keymap.set({ "n" }, "?", ":let @/='<C-R>=expand('<cword>')<CR>' | set hls<CR>")
-- visual mode searches for the selected text
keymap.set({ "v" }, "?", "y:let @/='<C-R>=escape(@\",'/\\')<CR>' | set hls<CR>")

-- delete current line in insert mode with shift-del
vim.keymap.set({ "i" }, "<S-Del>", "<ESC>ddi")

-- Flip betweeen recent buffer
keymap.set("n", "<BS>", "<C-^>")

-- Delete buffer
keymap.set("n", "<leader>z", "<leader>bd<CR>")

-- Don't yank on delete char
-- 17 Sep 23: Commented this so that cut functionalit
-- continues with X
-- Also switching to use cutlass
-- keymap.set("n", "x", '"_x')
-- keymap.set("n", "X", '"_X')
-- keymap.set("v", "x", '"_x')
-- keymap.set("v", "X", '"_X')
keymap.set("n", "<del>", '"_x')
keymap.set("v", "<del>", '"_x')
keymap.set("n", "dd", '"_dd')
-- keymap.set("v", "dd", '"_dd')
-- keymap.set("v", "d", '"_d')

-- Don't yank on cc
keymap.set("n", "cc", '"_cc')

-- Don't yank on visual paste
keymap.set("v", "p", '"_dP')

-- To clear the newly added comment when using Ctrl+Enter
-- keymap.set("i", "<C-CR>", "<CR><C-u>") -- Doesn't work, why?

-- U for redo, the opposite of u for undo.
keymap.set("n", "U", "<C-r>")

-- Insert Lines
keymap.set("n", "<C-o>", [[m`o<Esc>``]], { desc = "Insert line below" })
keymap.set("n", "<C-M-o>", [[m`O<Esc>``]], { desc = "Insert line above" })
keymap.set("i", "<C-o>", "<Esc>o", { desc = "Insert new line below when in insert mode" })
keymap.set("i", "<C-M-o>", "<Esc>O", { desc = "Insert new line above when in insert mode" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
keymap.set("x", "+", "g<C-a>")
keymap.set("x", "-", "g<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-M-a>", "gg<S-v>G")

-- Start and End of Line Movements
keymap.set("n", "<C-a>", "0")
keymap.set("n", "<C-e>", "$")
keymap.set("i", "<C-a>", "<C-o>0")
keymap.set("i", "<C-e>", "<C-o>$")
keymap.set("c", "<C-a>", "<Home>")
keymap.set("c", "<C-e>", "<End>")

-- Move Window
-- keymap.set("n", "<Space>", "<C-w>w")

-- Top and Bottom Navigation
keymap.set("n", "<End>", "<S-g>") -- Move to end of file using End key
keymap.set("n", "<Home>", "gg") -- Move to start of file using Home key

-- Duplicate Selection
-- keymap.set("v", "yys", "y'>o<Esc>p") -- Selects whole lines and then duplicates selection

-- Auto Indent current empty line
vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

-- Alt/Option Movement
keymap.set("i", "<M-Right>", "<C-Right>")
keymap.set("n", "<M-Left>", "b")
keymap.set("n", "<M-Right>", "e")
keymap.set("i", "<M-Left>", "<C-Left>")
keymap.set("i", "<M-Right>", "<C-Right>")

-- Text Selection with Shift in Normal Mode
keymap.set("n", "<S-Up>", "v<Up>")
keymap.set("n", "<S-Down>", "v<Down>")
keymap.set("n", "<S-Left>", "v<Left>")
keymap.set("n", "<S-Right>", "v<Right>")
keymap.set("n", "<S-M-Up>", "V<Up>")
keymap.set("n", "<S-M-Down>", "V<Down>")
keymap.set("n", "<S-M-Left>", "vb")
keymap.set("n", "<S-M-Right>", "ve")
keymap.set("n", "<S-PageUp>", "V<PageUp>")
keymap.set("n", "<S-PageDown>", "V<PageDown>")
keymap.set("n", "<S-End>", "VG$")
keymap.set("n", "<S-Home>", "Vgg")

-- Text Selection with Shift in Visual Mode
keymap.set("v", "<S-Up>", "<Up>")
keymap.set("v", "<S-Down>", "<Down>")
keymap.set("v", "<S-Left>", "<Left>")
keymap.set("v", "<S-Right>", "<Right>")
keymap.set("v", "<S-PageUp>", "<C-u>")
keymap.set("v", "<S-PageDown>", "<PageDown>")
keymap.set("v", "<S-M-Up>", "<Up>")
keymap.set("v", "<S-M-Down>", "<Down>")
keymap.set("v", "<S-M-Left>", "b")
keymap.set("v", "<S-M-Right>", "e")
keymap.set("v", "<Space>", "<Esc>")
keymap.set("v", "<Enter>", "<Esc>")

-- Text Selection with Shift in Insert Mode
keymap.set("i", "<S-Up>", "<Esc>v<Up>")
keymap.set("i", "<S-Down>", "<Esc>v<Down>")
keymap.set("i", "<S-Left>", "<Esc>v<Left>")
keymap.set("i", "<S-Right>", "<Esc>v<Right>")

-- Copy Paste Shortcuts in Visual Mode
keymap.set("v", "<C-c>", "y<Esc>")
keymap.set("v", "<C-x>", "d<Esc>")
keymap.set("v", "<C-v>", "[pi") -- Paste above while preserving indentation

-- Paste in normal mode
keymap.set("n", "<C-v>", "[p") -- Paste above while preserving indentation

-- Copy Paste Shortcuts in Insert Mode
keymap.set("i", "<C-v>", "<C-r><C-p>*")
keymap.set("i", "<C-z>", "<Esc>ui")

-- Alt Backspace
keymap.set("n", "<M-Backspace>", "db")
keymap.set("i", "<M-Backspace>", "<C-W>")

-- tabs
vim.api.nvim_set_keymap("n", "<leader>ta", "<Cmd>$tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>to", "<Cmd>tabonly<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tn", "<Cmd>tabn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tp", "<Cmd>tabp<CR>", { noremap = true, silent = true })

-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", "<Cmd>-tabmove<CR>", { noremap = true, silent = true })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", "<Cmd>+tabmove<CR>", { noremap = true, silent = true })

keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")

keymap.set("n", "<M-1>", "<Cmd>tabn 1<CR>", {})
keymap.set("n", "<M-2>", "<Cmd>tabn 2<CR>", {})
keymap.set("n", "<M-3>", "<Cmd>tabn 3<CR>", {})
keymap.set("n", "<M-4>", "<Cmd>tabn 4<CR>", {})
keymap.set("n", "<M-5>", "<Cmd>tabn 5<CR>", {})
keymap.set("n", "<M-6>", "<Cmd>tabn 6<CR>", {})
keymap.set("n", "<M-7>", "<Cmd>tabn 7<CR>", {})
keymap.set("n", "<M-8>", "<Cmd>tabn 8<CR>", {})

keymap.set("n", "]<tab>", "<cmd>tabn<cr>", { noremap = true, silent = true })
keymap.set("n", "[<tab>", "<cmd>tabp<cr>", { noremap = true, silent = true })

keymap.set("n", "<leader><tab>", "<cmd>$tabnew<cr>", { noremap = true, silent = true })

-- Unset the default terminal maps
keymap.del("n", "<leader>ft")
keymap.del("n", "<leader>fT")

-- Resize mode
vim.keymap.set("n", "<C-w>r", require("smart-splits").start_resize_mode)

-- moving between splits
vim.keymap.set("n", "<C-Left>", require("smart-splits").move_cursor_left, { silent = true, noremap = true })
vim.keymap.set("n", "<C-Down>", require("smart-splits").move_cursor_down, { silent = true, noremap = true })
vim.keymap.set("n", "<C-Up>", require("smart-splits").move_cursor_up, { silent = true, noremap = true })
vim.keymap.set("n", "<C-Right>", require("smart-splits").move_cursor_right, { silent = true, noremap = true })
