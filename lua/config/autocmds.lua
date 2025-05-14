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

vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  pattern = '*',
  callback = function()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float {
      scope = 'cursor',
      focusable = false,
      close_events = {
        'CursorMoved',
        'CursorMovedI',
        'BufHidden',
        'InsertCharPre',
        'WinLeave',
      },
    }
  end,
})

-- ensure fold settings are applied on buffer open
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    vim.defer_fn(function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true
    end, 20)
  end,
})
