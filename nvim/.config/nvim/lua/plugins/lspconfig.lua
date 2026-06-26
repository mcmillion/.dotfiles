-- nvim-lspconfig: ships the base lsp/*.lua server configs (cmd, filetypes,
-- root_dir, settings) that the native vim.lsp.enable() in config/lsp.lua
-- merges our ~/.config/nvim/lsp/*.lua overrides on top of.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}
