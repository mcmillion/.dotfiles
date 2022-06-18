utils = require('utils')
local silent_noremap = utils.silent_noremap

silent_noremap('n', '<leader>gs', ':vertical Git<cr>')
silent_noremap('n', '<Leader>gd', ':Gdiffsplit!<CR>')
silent_noremap('n', '<Leader>gb', ':Git blame<CR>')
silent_noremap('n', '<Leader>gw', ':Gwrite<CR>')
silent_noremap('n', '<Leader>gr', ':Gread<CR>')
