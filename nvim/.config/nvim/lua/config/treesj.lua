utils = require("utils")
local silent_noremap = utils.silent_noremap

require("treesj").setup({
  use_default_keymaps = false,
})

silent_noremap("n", "<Leader>m", ":TSJToggle<CR>")
silent_noremap("n", "<Leader>j", ":TSJJoin<CR>")
silent_noremap("n", "<Leader>k", ":TSJSplit<CR>")
