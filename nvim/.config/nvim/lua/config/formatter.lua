local prettierd = {
  function ()
    return {
      exe = "prettierd",
      args = { vim.api.nvim_buf_get_name(0) },
      stdin = true
    }
  end
}

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = prettierd,
    typescript = prettierd,
    javascriptreact = prettierd,
    typescriptreact = prettierd,
    json = prettierd,
    css = prettierd,
    scss = prettierd,
    graphql = prettierd,
  },
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]], true)
