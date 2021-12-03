utils = require('utils')
local noremap = utils.noremap

noremap('n', '<leader>gs', ':vertical Git<cr>')
noremap('n', '<Leader>gd', ':Gdiffsplit!<CR>')
noremap('n', '<Leader>gb', ':Git blame<CR>')
noremap('n', '<Leader>gw', ':Gwrite<CR>')
noremap('n', '<Leader>gr', ':Gread<CR>')
