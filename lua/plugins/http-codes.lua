return {
  'barrett-ruth/http-codes.nvim',
  config = true,
  dependencies = 'nvim-telescope/telescope.nvim',
  keys = { { '<leader>H', '<cmd>HTTPCodes<cr>', desc = 'List HTTP codes' } },
}
