common = require('config/lspconfig-common')
local on_attach = common.on_attach

local function organize_imports()
  if not bufnr then bufnr = vim.api.nvim_get_current_buf() end
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 500)
end

require('lspconfig').tsserver.setup({
  on_attach = on_attach,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
})
