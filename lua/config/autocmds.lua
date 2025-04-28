-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local group = vim.api.nvim_create_augroup('lsp_codelens_refresh', { clear = false })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter' }, {
  desc = 'Refresh codelens on InsertLeave and BufEnter',
  group = group,
  callback = function(args)
    vim.lsp.codelens.refresh { bufnr = args.buf }
  end,
})
