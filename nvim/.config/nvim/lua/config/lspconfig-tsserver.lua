common = require('config/lspconfig-common')
local on_attach = utils.on_attach

require('lspconfig').tsserver.setup({ on_attach = on_attach })
