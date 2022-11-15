utils = require('utils')
local noremap = utils.noremap
local silent_noremap = utils.silent_noremap

-- remap the leader key to <Space>
vim.api.nvim_set_keymap('n', '<space>', '', {})
vim.g.mapleader = ' '

-- Disable ex mode
silent_noremap('n', 'Q', '<nop>')

-- Disable undo text in insert mode
silent_noremap('i', '<c-u>', '<nop>')

-- Remove last search highlight
silent_noremap('n', '<leader><esc>', ':nohlsearch<cr>')

-- Close quickfix and remove highlight
silent_noremap('n', '<leader>qx', ':cclose<cr>:noh<cr>')

-- Split line
silent_noremap('n', 'K', 'i<cr><esc>')

-- Remap up/down to keep line centered
silent_noremap('n', '<c-u>', '<c-u>zz')
silent_noremap('n', '<c-d>', '<c-d>zz')

-- Remap search next to keep search in the middle of the screen
silent_noremap('n', 'n', 'nzzzv')
silent_noremap('n', 'N', 'Nzzzv')

-- Quicker quit
silent_noremap('n', 'QQ', ':q<cr>')

-- Dumb hack to format with :EslintFixAll before saving, since the BufPreWrite
-- route breaks undo
vim.cmd([[
function! MaybeFormatAndSave()
  if exists(":EslintFixAll")
    :EslintFixAll
  else
    :Autoformat
  endif

  write
endfunction
]])
silent_noremap('n', '<leader>w', ':call MaybeFormatAndSave()<cr>')

-- Easy change global with next
silent_noremap('n', 'c*', '*Ncgn')

-- Window resizing
silent_noremap('n', '<leader><up>', ':5wincmd +<cr>')
silent_noremap('n', '<leader><down>', ':5wincmd -<cr>')
silent_noremap('n', '<leader><left>', ':5wincmd <<cr>')
silent_noremap('n', '<leader><right>', ':5wincmd ><cr>')

-- Panes / Tabs
silent_noremap('n', '<leader>-', ':vsplit %:h<cr>')
silent_noremap('n', '<leader>_', ':split %:h<cr>')
silent_noremap('n', '<leader>=', ':tab split %:h<cr>')

-- Delete selected to text to void and paste default register
silent_noremap('v', '<leader>p', '"_dP')

-- Yank to end of line because consistency makes sense
silent_noremap('n', 'Y', 'y$')

-- Substitute current word
noremap('n', '<leader>s', ':s/<c-r><c-w>//g<left><left>')
noremap('n', '<leader>S', ':%s/<c-r><c-w>//g<left><left>')
noremap('x', '<leader>s', ':s///g<left><left><left>')

-- Popup Terminal
silent_noremap('n', '<leader>`', ':FloatermNew --autoclose=1<cr>')

-- YAML path
silent_noremap('n', '<leader>yp', ':call yaml_path#show()<CR>')
