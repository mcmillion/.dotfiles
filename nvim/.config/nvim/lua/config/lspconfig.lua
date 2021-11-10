vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = false,
    underline = false,
    update_in_insert = false,
    virtual_text = true,
  })

require('config/lspconfig-eslint')
require('config/lspconfig-tsserver')
require('config/lspconfig-omnisharp')
require('config/lspconfig-solargraph')
