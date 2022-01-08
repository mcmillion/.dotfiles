common = require('config/lspconfig-common')
local on_attach = common.on_attach

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      only_current_line = true,
    },
  },
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {command = "clippy"},
      },
    },
  },
})
