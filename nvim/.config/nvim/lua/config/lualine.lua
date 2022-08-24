local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return require('lualine').setup({
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(s) return s:sub(1,1) end },
    },
    lualine_b = {
      { 'branch', fmt = function(s)
        if string.len(s) < 25
        then
          return s
        else
          return s:sub(1,24) .. '…'
        end
      end },
      { 'diff',
        source = diff_source,
        diff_color = {
          added = { fg = '#98c379' },
          modified = { fg = '#e5c07b' },
          removed = { fg = '#e06c75' },
        }
      },
      { 'diagnostics', sources={'nvim_diagnostic'}},
    },
    lualine_c = {{ 'filename', path = 1, shorting_target = 30 }},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{ 'filename', path = 1, shorting_target = 30 }},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})
