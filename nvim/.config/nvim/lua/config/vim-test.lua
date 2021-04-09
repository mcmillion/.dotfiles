utils = require('utils')
local noremap = utils.noremap

vim.cmd [[
  let test#strategy = "vimux"
  let test#ruby#rspec#executable = 'bundle exec rspec'
]]

noremap('n', '<Leader>t', ':TestNearest<CR>')
noremap('n', '<Leader>tf', ':TestFile<CR>')
