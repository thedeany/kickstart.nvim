local function getLen(str, start_pos)
  local byte = string.byte(str, start_pos)
  if not byte then
    return nil
  end

  return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
  for letter, color in pairs(colors) do
    local color_name = 'AlphaJemuelKwelKwelWalangTatay' .. letter
    vim.api.nvim_set_hl(0, color_name, color)
    colors[letter] = color_name
  end

  local colorized = {}

  for i, line in ipairs(header_color_map) do
    local colorized_line = {}
    local pos = 0

    for j = 1, #line do
      local start = pos
      pos = pos + getLen(header[i], start + 1)

      local color_name = colors[line:sub(j, j)]
      if color_name then
        table.insert(colorized_line, { color_name, start, pos })
      end
    end

    table.insert(colorized, colorized_line)
  end

  return colorized
end

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'alpha.themes.theta'
    theme.file_icons.provider = 'devicons'

    local color_map = {
      [[0000000000000000000000000000000]],
      [[0000330000000088000000000000000]],
      [[11223000050077800900B00CD000000]],
      [[112203445566778899AABBCC0DEEFFF]],
      [[00000000000000000000000000EEF00]],
      [[0000000000000000000000000DEE000]],
      [[0000000000000000000000000000000]],
    }
    local header = {
      [[                               ]],
      [[    /)        /)               ]],
      [[_/_(/    _  _(/  _  _  __      ]],
      [[(__/ )__(/_(_(__(/_(_(_/ (_(_/_]],
      [[                          .-/  ]],
      [[                         (_/   ]],
      [[                               ]],
    }

    local colors = {
      ['0'] = { fg = '#000000' },
      ['1'] = { fg = '#fd53c9' },
      ['2'] = { fg = '#ff52be' },
      ['3'] = { fg = '#ff52b4' },
      ['4'] = { fg = '#ff53aa' },
      ['5'] = { fg = '#ff57a1' },
      ['6'] = { fg = '#ff5b97' },
      ['7'] = { fg = '#ff5f8f' },
      ['8'] = { fg = '#ff6386' },
      ['9'] = { fg = '#ff667d' },
      ['A'] = { fg = '#ff6a75' },
      ['B'] = { fg = '#ff6f6d' },
      ['C'] = { fg = '#ff7566' },
      ['D'] = { fg = '#ff7a60' },
      ['E'] = { fg = '#fc805a' },
      ['F'] = { fg = '#f78555' },
    }

    theme.header.val = header
    theme.header.opts = {
      hl = colorize(header, color_map, colors),
      position = 'center',
    }

    require('alpha').setup(theme.config)
  end,
}
