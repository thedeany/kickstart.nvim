return {
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    enabled = true,
    ---@type NoiceConfig
    opts = {
      -- cmdline = {
      --   view = 'cmdline',
      -- },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            find = '%d+L, %d+B',
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = '50%',
                col = '50%',
              },
              size = {
                min_width = 60,
                width = 'auto',
                height = 'auto',
              },
            },
            cmdline_popupmenu = {
              position = {
                row = '67%',
                col = '50%',
              },
            },
          },
        },
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    --stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
    },
  },
}
