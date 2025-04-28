-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<Esc>'] = 'close_window',
        },
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_hidden = false, -- Windows hidden files
        never_show = {
          '.DS_Store',
        },
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          --auto close
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
  },
}
