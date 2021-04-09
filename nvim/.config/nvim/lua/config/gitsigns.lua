require('gitsigns').setup({
})

vim.cmd[[
  hi! GitSignsAdd guifg=#98c379 ctermfg=114 guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
  hi! GitSignsChange guifg=#e5c07b ctermfg=180 guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
  hi! GitSignsDelete guifg=#e06c75 ctermfg=168 guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
]]
