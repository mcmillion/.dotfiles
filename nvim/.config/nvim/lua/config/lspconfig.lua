vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  })

vim.diagnostic.config({
  float = {
    source = "always",
  },
})

-- Diagnostic Icon Settings
local signs = { Error = " ", Warn = "⚠", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Float Border Settings
local border = {
  {"🭽", "FloatBorder"},
  {"▔", "FloatBorder"},
  {"🭾", "FloatBorder"},
  {"▕", "FloatBorder"},
  {"🭿", "FloatBorder"},
  {"▁", "FloatBorder"},
  {"🭼", "FloatBorder"},
  {"▏", "FloatBorder"},
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

require('config/lspconfig-eslint')
-- require('config/lspconfig-stylelint')
require('config/lspconfig-tailwindcss')
require('config/lspconfig-tsserver')
-- require('config/lspconfig-omnisharp')
-- require('config/lspconfig-solargraph')
