common = require('config/lspconfig-common')
local on_attach = common.on_attach

require('lspconfig').tailwindcss.setup({
  on_attach = on_attach,
  -- filetypes = {
  --   'css',
  --   'scss',
  -- },
})
