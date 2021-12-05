common = require('config/lspconfig-common')
local on_attach = common.on_attach

require('lspconfig').solargraph.setup({ on_attach = on_attach })
