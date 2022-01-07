local auto = vim.api.nvim_exec

vim.g.colors_name = 'onedark'

auto([[
  augroup ColorschemeTweaks
    autocmd!

    autocmd ColorScheme * highlight TabLineFill guifg=#5c6370 guibg=#2d323d
    autocmd ColorScheme * highlight TabLine guifg=#5c6370 guibg=#2d323d
    autocmd ColorScheme * highlight TabLineSel guifg=#abb2bf guibg=#3f4452
    autocmd ColorScheme * highlight Title guifg=#5c6370 guibg=NONE

    autocmd ColorScheme * highlight CursorLine guibg=#2c323d
    autocmd ColorScheme * highlight CursorLineNr guifg=#858b96 guibg=#2c323d gui=NONE

    autocmd ColorScheme * highlight NormalFloat guibg=#222529
    autocmd ColorScheme * highlight FloatBorder guifg=#363945 guibg=#222529
    autocmd ColorScheme * highlight DiagnosticError guifg=#f44747
    autocmd ColorScheme * highlight DiagnosticWarn guifg=#e5c07b
    autocmd ColorScheme * highlight DiagnsoticInfo guifg=#abb2bf
    autocmd ColorScheme * highlight DiagnosticHint guifg=#abb2bf

    autocmd ColorScheme * highlight Pmenu guifg=#abb2bf guibg=#222529
    autocmd ColorScheme * highlight PmenuSel guifg=#abb2bf guibg=#2c323d
    autocmd ColorScheme * highlight PmenuSbar guifg=NONE guibg=#222529
    autocmd ColorScheme * highlight PmenuThumb guifg=NONE guibg=#2c323d

    autocmd ColorScheme * highlight Comment guifg=#686f7c
  augroup END
]], true)
