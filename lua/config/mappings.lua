-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- mine

vim.keymap.set('n', '<Leader><Leader>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<Leader>x', ':.lua<CR>', { desc = 'E[x]ecute current Lua line' })
vim.keymap.set('v', '<Leader>x', ':lua<CR>', { desc = 'E[x]ecute visual selection' })

vim.keymap.set('n', '[b', ':bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<Leader>c', function()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  vim.cmd 'bdelete'
  if not bufs[2] then
    require('alpha').start()
  end
end, { desc = 'Close buffer' })

vim.keymap.set('n', 'x', 'd') -- remap x (delete char under cursor) to yank-delete in case we do ever want to use that; think ctrl+X (cut)
vim.keymap.set('n', 'd', '"_d') -- prevents yank on delete (which we almost never want)
vim.keymap.set('v', 'd', '"_d') -- prevents yank on delete (which we almost never want)

vim.keymap.set('n', '<Leader>y', '"+y', { desc = 'Yank to clipboard' }) -- yank to system clipboard

vim.keymap.set('n', 'grh', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
end, { desc = 'Toggle inlay hints' })

local betterEscapeMaps = { 'kk', 'jj', 'jk', 'kj' }
for _, map in pairs(betterEscapeMaps) do
  vim.keymap.set('i', map, '<Esc>')
end

vim.keymap.set({ 'n', 't' }, '<C-t>', '<cmd>ToggleTerm direction=float<CR>')
