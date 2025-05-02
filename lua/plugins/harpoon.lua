return {
  'ThePrimeagen/harpoon',
  --branch = "harpoon2",
  commit = 'e76cb03c420bb74a5900a5b3e1dde776156af45f', -- marks won't persist across nvim sessions unless this commit is pinned for some reason
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    local exts = require 'harpoon.extensions'

    harpoon:setup {}

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local finder = function()
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = file_paths,
        }
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = finder(),
          -- previewer = conf.file_previewer {},
          previewer = false,
          sorter = conf.generic_sorter {},
          sorting_strategy = 'ascending',
          layout_config = {
            height = 0.3,
            width = 0.5,
            prompt_position = 'top',
            preview_cutoff = 120,
          },
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<C-d>', function()
              local state = require 'telescope.actions.state'
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(finder())
            end)
            return true
          end,
        })
        :find()
    end

    harpoon:extend(exts.builtins.navigate_with_number())
    -- this builtin must be newer than the pinned commit; this function is called `highlight_current_file` in the repo
    -- harpoon:extend({
    --     UI_CREATE = function(cx)
    --         for line_number, file in pairs(cx.contents) do
    --             if string.find(cx.current_file, file, 1, true) then
    --                 -- highlight the harpoon menu line that corresponds to the current buffer
    --                 vim.api.nvim_buf_add_highlight(
    --                     cx.bufnr,
    --                     -1,
    --                     "CursorLineNr",
    --                     line_number - 1,
    --                     0,
    --                     -1
    --                 )
    --                 -- set the position of the cursor in the harpoon menu to the start of the current buffer line
    --                 vim.api.nvim_win_set_cursor(cx.win_id, { line_number, 0 })
    --             end
    --         end
    --     end,
    -- })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', 'H', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', 'L', function()
      harpoon:list():next()
    end)
    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open Harpoon window' })
    vim.keymap.set('n', '<Leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })
  end,
}
