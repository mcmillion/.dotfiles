utils = require('utils')
local noremap = utils.noremap

noremap('n', '<c-b>', ":FloatermNew --width=0.8 --height=0.8 bundle exec rspec<cr>")
