local auto = vim.api.nvim_exec

-- Additional filetypes
auto([[
augroup additional_filetypes
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

-- Open quick fix in vertical split
-- https://stackoverflow.com/a/16743676/479732
auto([[
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L
]], true)

-- Open diagnostics on hover
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Better :grep
vim.cmd([[
function! Grep(...)
  call matchadd('Search', a:0)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
]])
