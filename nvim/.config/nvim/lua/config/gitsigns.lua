require('gitsigns').setup({})

vim.cmd[[
  hi! GitSignsAdd guifg=#98c379 guibg=#282c34
  hi! GitSignsChange guifg=#e5c07b guibg=#282c34
  hi! GitSignsDelete guifg=#e06c75 guibg=#282c34
]]
