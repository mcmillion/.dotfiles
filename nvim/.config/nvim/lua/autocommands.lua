local auto = vim.api.nvim_exec

-- Additional filetypes
auto([[
augroup addition_filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.env.* set filetype=sh
  autocmd BufRead,BufNewFile Procfile set filetype=sh
  autocmd BufRead,BufNewFile Procfile.* set filetype=sh
augroup END
]], true)

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

-- Automatically reload ultisnips after save
auto([[
autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets
]], true)

-- Open diagnostics on hover
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
