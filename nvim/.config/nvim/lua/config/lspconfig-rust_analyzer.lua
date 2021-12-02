common = require('config/lspconfig-common')
local on_attach = utils.on_attach

require('lspconfig').rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {command = "clippy"}
    }
  }
})
