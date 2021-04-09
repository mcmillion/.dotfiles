local auto = vim.api.nvim_exec

-- Highlight yanked text
auto([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]], true)
