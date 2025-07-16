return {
  "tpope/vim-fugitive",
  lazy = false,

  config = function()
    vim.keymap.set("n", "<leader>gs", ":vertical Git<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit!<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>gw", ":Gwrite<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>gr", ":Gread<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "dp", ":diffput<CR>", { buffer = true })
  end,
}
