vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('config/lspconfig-eslint')
require('config/lspconfig-tsserver')
require('config/lspconfig-omnisharp')
require('config/lspconfig-rust_analyzer')
require('config/lspconfig-solargraph')
