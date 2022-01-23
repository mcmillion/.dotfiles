common = require('config/lspconfig-common')
local on_attach = common.on_attach

require('lspconfig').stylelint_lsp.setup({
  on_attach = on_attach,
  filetypes = {
    'css',
    'scss',
  },
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      autoFixOnSave = true,
    }
  }
})

vim.cmd 'au BufWritePre *.css lua vim.lsp.buf.formatting_sync()'
vim.cmd 'au BufWritePre *.scss lua vim.lsp.buf.formatting_sync()'
