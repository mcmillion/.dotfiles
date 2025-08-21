return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      -- json = { "jq" },
      lua = { "stylua" },
      rust = { "rustfmt" },
      -- typescript = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- gdscript = { "gdformat" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
