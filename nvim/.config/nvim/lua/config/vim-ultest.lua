local auto = vim.api.nvim_exec

vim.cmd('let test#javascript#reactscripts#options = "--watchAll=false"')
vim.g.ultest_use_pty = 1

vim.g.ultest_running_sign = '◌'

-- Automatically run tests on save
auto([[
augroup UltestRunner
  au!
  au BufWritePost * UltestNearest
augroup END
]], true)

vim.cmd[[
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
nmap <leader>t <Plug>(ultest-summary-toggle)
]]
