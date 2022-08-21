require("todo-comments").setup({
})

vim.api.nvim_set_keymap("n", "<leader>xt", "<cmd>TodoTrouble<cr>",
  {silent = true, noremap = true}
)
