local auto = vim.api.nvim_exec

-- Highlight yanked text
auto([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]], true)

-- Cursorline in active pane
auto([[
  augroup CursorLine
    autocmd!
    au VimEnter,WinEnter,BufWinEnter,FocusGained * setlocal cursorline
    au WinLeave,FocusLost * setlocal nocursorline
  augroup END
]], true)
