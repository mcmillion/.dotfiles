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

-- Format on save
vim.cmd('autocmd BufWritePre * :Autoformat')
vim.cmd('autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs :EslintFixAll')

-- Open diagnostics on hover
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
