utils = require('utils')
local noremap = utils.noremap

noremap('n', '<leader><leader>', [[<cmd>lua require('telescope.builtin').find_files({ hidden=true })<cr>]])
noremap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]])
noremap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
noremap('n', '<leader>fgl', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]])
noremap('n', '<leader>fgb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])

return require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--follow',
      '--ignore',
    },
  }
})
