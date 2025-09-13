vim.opt_local.listchars = {
  tab = "  ",
  trail = "·",
  extends = "→",
  precedes = "←",
}

-- vim.opt_local.foldmethod = "expr"
-- vim.opt_local.foldexpr = "GodotFolds()"
-- vim.opt_local.tabstop = 4
-- vim.opt_local.shiftwidth = 4
-- vim.opt_local.softtabstop = 4

vim.keymap.set("n", "<leader>t", ":GutTest<CR>", {
  buffer = true,
  desc = "Run GUT tests in tmux popup",
})

vim.keymap.set("n", "<leader>T", ":GutTestHeaded<CR>", {
  buffer = true,
  desc = "Run current GUT test in headed mode",
})
