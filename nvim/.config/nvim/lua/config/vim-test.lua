utils = require('utils')
local noremap = utils.noremap

vim.g.VimuxHeight = '40'
vim.g.VimuxOrientation = 'h'

vim.g['test#strategy'] = 'vimux'
vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec -f d'

noremap('n', '<Leader>t', ':TestNearest<CR>')
noremap('n', '<Leader>tt', ':TestFile<CR>')
