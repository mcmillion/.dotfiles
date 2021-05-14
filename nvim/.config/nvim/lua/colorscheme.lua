local auto = vim.api.nvim_exec

vim.g.colors_name = 'onedark'

auto([[
  augroup ColorschemeTweaks
    autocmd!

    autocmd ColorScheme * highlight TabLineFill guifg=#5c6370 guibg=#2d323c
    autocmd ColorScheme * highlight TabLine guifg=#5c6370 guibg=#2d323c
    autocmd ColorScheme * highlight TabLineSel guifg=#abb2bf guibg=#3f4452
    autocmd ColorScheme * highlight Title guifg=#5c6370 guibg=NONE

    autocmd ColorScheme * hi TSNamespace guifg=#61afef guibg=NON
  augroup END
]], true)
