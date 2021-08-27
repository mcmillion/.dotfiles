common = require('config/lspconfig-common')
local on_attach = utils.on_attach

local pid = vim.fn.getpid()
local omnisharp_bin = "/usr/local/bin/omnisharp"
require('lspconfig').omnisharp.setup({
  cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
  on_attach = on_attach
})
