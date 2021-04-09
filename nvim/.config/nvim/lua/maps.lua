utils = require('utils')
local noremap = utils.noremap

-- remap the leader key to <Space>
vim.api.nvim_set_keymap('n', '<space>', '', {})
vim.g.mapleader = ' '

-- Disable ex mode
noremap('n', 'Q', '<nop>')

-- Disable undo text in insert mode
noremap('i', '<c-u>', '<nop>')

-- Remove last search highlight
noremap('n', '<leader><esc>', ':nohlsearch<cr>')

-- Close quickfix and remove highlight
noremap('n', '<leader>qx', ':cclose<cr>:noh<cr>')

-- Split line
noremap('n', 'K', 'i<cr><esc>')

-- Remap search next to keep search in the middle of the screen
noremap('n', 'n', 'nzzzv')
noremap('n', 'N', 'Nzzzv')

-- Quicker quit and save mappings
noremap('n', 'QQ', ':q<cr>')
noremap('n', '<leader>w', ':w<cr>')

-- Easy change global with next
noremap('n', 'c*', '*Ncgn')

-- Window resizing
noremap('n', '<leader><up>', ':5wincmd +<cr>')
noremap('n', '<leader><down>', ':5wincmd -<cr>')
noremap('n', '<leader><left>', ':5wincmd <<cr>')
noremap('n', '<leader><right>', ':5wincmd ><cr>')

-- Panes / Tabs
noremap('n', '<leader>-', ':vsplit %:h<cr>')
noremap('n', '<leader>_', ':split %:h<cr>')
noremap('n', '<leader>=', ':tab split %:h<cr>')

-- Delete selected to text to void and paste default register
noremap('v', '<leader>p', '"_dP')

-- Yank to end of line because consistency makes sense
noremap('n', 'Y', 'y$')

-- Substitute current word
noremap('n', '<leader>s', ':s/<c-r><c-w>//g<left><left>')
noremap('n', '<leader>S', ':%s/<c-r><c-w>//g<left><left>')
noremap('x', '<leader>s', ':s///g<left><left><left>')
