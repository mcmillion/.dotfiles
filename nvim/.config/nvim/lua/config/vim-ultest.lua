local auto = vim.api.nvim_exec

vim.cmd('let test#javascript#reactscripts#options = "--watchAll=false"')
vim.g.ultest_use_pty = 1

-- Automatically run tests on save
auto([[
augroup UltestRunner
au!
au BufWritePost * Ultest
augroup END
]], true)

vim.cmd[[
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
]]
