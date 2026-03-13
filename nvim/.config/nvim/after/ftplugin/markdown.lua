-- Enable word wrap for markdown files
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Auto-continue list bullets on Enter
vim.opt_local.formatoptions:append("r")
vim.opt_local.comments = "b:-,b:*,b:+"

-- Use 2-space tabs
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
