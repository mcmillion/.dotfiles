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

    autocmd ColorScheme * hi TSNamespace guifg=#61afef guibg=NON

    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextError guifg=#e5c07b
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextWarning guifg=#e5c07b
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextInformation guifg=#e5c07b
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextHint guifg=#e5c07b

    autocmd ColorScheme * highligh Pmenu guifg=#abb2bf guibg=#222529
    autocmd ColorScheme * highligh PmenuSel guifg=#abb2bf guibg=#2c323d
    autocmd ColorScheme * highligh PmenuSbar guifg=NONE guibg=#222529
    autocmd ColorScheme * highligh PmenuThumb guifg=NONE guibg=#2c323d
  augroup END
]], true)
