return require('lualine').setup({
  options = {
    theme = custom_onedark,
    section_separators = { '', '' },
    component_separators = { '', '' },
  },
  sections = {
    lualine_b = {
      'branch',
      { 'diff', diff_color = {
        added = { fg = '#98c379' },
        modified = { fg = '#e5c07b' },
        removed = { fg = '#e06c75' },
      }},
      { 'diagnostics', sources={'nvim_diagnostic'}},
    },
    lualine_c = {{ 'filename', path = 1, shorting_target = 30 }},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})
