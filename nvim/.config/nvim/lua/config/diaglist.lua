utils = require("utils")
local silent_noremap = utils.silent_noremap

require("diaglist").init({
  debug = false,
  debounce_ms = 150,
})

silent_noremap("n", "<leader>d", "<cmd>lua require('diaglist').open_all_diagnostics()<cr>")
