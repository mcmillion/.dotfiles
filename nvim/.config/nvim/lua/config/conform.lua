require("conform").setup({
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "jq" },
    lua = { "stylua" },
    rust = { "rustfmt" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
