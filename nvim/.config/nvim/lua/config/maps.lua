-- Disable ex mode
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

-- Disable undo text in insert mode
vim.keymap.set("i", "<c-u>", "<nop>", { noremap = true, silent = true })

-- Remove last search highlight
vim.keymap.set("n", "<leader><esc>", ":nohlsearch<cr>:cclose<cr>:echon ''<cr>", { noremap = true, silent = true })

-- Split line
vim.keymap.set("n", "K", "i<cr><esc>", { noremap = true, silent = true })

-- Remap search next to keep search in the middle of the screen
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Quicker quit
vim.keymap.set("n", "QQ", ":q<cr>", { noremap = true, silent = true })

-- Quicker save
vim.keymap.set("n", "<leader>w", ":w<cr>", { noremap = true, silent = true })

-- Easy change global with next
vim.keymap.set("n", "c*", "*Ncgn", { noremap = true, silent = true })

-- Window resizing
vim.keymap.set("n", "<leader><up>", ":5wincmd +<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><down>", ":5wincmd -<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><left>", ":5wincmd <<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><right>", ":5wincmd ><cr>", { noremap = true, silent = true })

-- Panes / Tabs
vim.keymap.set("n", "<leader>-", ":vsplit %:h<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>_", ":split %:h<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>=", ":tab split %:h<cr>", { noremap = true, silent = true })

-- Delete selected to text to void and paste default register
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, silent = true })

-- Yank to end of line because consistency makes sense
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true })

-- Substitute current word
vim.keymap.set("n", "<leader>s", ":s/<c-r><c-w>//g<left><left>", { noremap = true })
vim.keymap.set("n", "<leader>S", ":%s/<c-r><c-w>//g<left><left>", { noremap = true })
vim.keymap.set("x", "<leader>s", ":s///g<left><left><left>", { noremap = true })

-- Floating terminal
vim.keymap.set("n", "<leader>`", function()
  -- This tries to get git root, falls back to current directory
  local cmd = "git rev-parse --show-toplevel 2>/dev/null || echo " .. vim.fn.getcwd()
  local root = vim.fn.system(cmd):gsub("\n", "")
  vim.fn.system(string.format('tmux popup -w 80%% -h 80%% -E "cd %s && zsh"', root))
end, { noremap = true, silent = true })
