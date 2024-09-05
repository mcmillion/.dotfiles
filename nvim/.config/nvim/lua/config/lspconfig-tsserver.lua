common = require("config/lspconfig-common")
local on_attach = common.on_attach

require("lspconfig").ts_ls.setup({
  on_attach = on_attach,
})
