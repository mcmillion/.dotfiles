util = require('utils')
local noremap = utils.noremap

require('Navigator').setup()

noremap('n', "<c-h>", "<CMD>lua require('Navigator').left()<CR>")
noremap('n', "<c-k>", "<CMD>lua require('Navigator').up()<CR>")
noremap('n', "<c-l>", "<CMD>lua require('Navigator').right()<CR>")
noremap('n', "<c-j>", "<CMD>lua require('Navigator').down()<CR>")
