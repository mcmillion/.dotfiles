util = require('utils')
local noremap = utils.noremap

require('nvim-tree').setup({
  hijack_netrw = false,
})

noremap('n', '<c-n>', ":NvimTreeToggle<CR>")
