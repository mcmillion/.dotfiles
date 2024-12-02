local lspconfig = require("lspconfig")

common = require("config/lspconfig-common")
local on_attach = common.on_attach

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("package.json"),
})
