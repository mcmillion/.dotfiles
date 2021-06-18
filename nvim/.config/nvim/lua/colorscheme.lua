local auto = vim.api.nvim_exec

vim.g.colors_name = 'onedark'

auto([[
  augroup ColorschemeTweaks
    autocmd!

    autocmd ColorScheme * highlight TabLineFill guifg=#5c6370 guibg=#21252b
    autocmd ColorScheme * highlight TabLine guifg=#5c6370 guibg=#21252b
    autocmd ColorScheme * highlight TabLineSel guifg=#abb2bf guibg=#5c6370
    autocmd ColorScheme * highlight Title guifg=#5c6370 guibg=NONE

    autocmd ColorScheme * highlight CursorLine guibg=#2c313c
    autocmd ColorScheme * highlight CursorLineNr guifg=#858b96 gui=NONE

    autocmd ColorScheme * hi TSNamespace guifg=#61afef guibg=NON

    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextError guifg=#e0af68
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextWarning guifg=#e0af68
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextInformation guifg=#e0af68
    autocmd ColorScheme * highlight LspDiagnosticsVirtualTextHint guifg=#e0af68
  augroup END
]], true)
