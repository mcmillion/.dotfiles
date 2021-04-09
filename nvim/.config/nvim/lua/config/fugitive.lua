utils = require('utils')
local noremap = utils.noremap

noremap('n', '<leader>gs', ':vertical Gstatus<cr>')
noremap('n', '<Leader>gd', ':Gdiffsplit!<CR>')
noremap('n', '<Leader>gb', ':Gblame<CR>')
noremap('n', '<Leader>gw', ':Gwrite<CR>')
noremap('n', '<Leader>gr', ':Gread<CR>')
