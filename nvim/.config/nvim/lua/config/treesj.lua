utils = require('utils')
local noremap = utils.noremap

require('treesj').setup({
  use_default_keymaps = false,
})

noremap('n', '<Leader>m', ':TSJToggle<CR>')
noremap('n', '<Leader>j', ':TSJJoin<CR>')
noremap('n', '<Leader>k', ':TSJSplit<CR>')
