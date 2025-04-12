-- remap the leader key to <Space>
vim.api.nvim_set_keymap("n", "<space>", "", {})
vim.g.mapleader = " "

-- Set global window border
vim.o.winborder = "single"

-- Use termgui colors and dark mode
vim.o.termguicolors = true
vim.o.background = "dark"

-- Disable backups and swaps
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.bo.swapfile = false
vim.o.undofile = true
vim.bo.undofile = true

-- Force diff to vertical
vim.o.diffopt = vim.o.diffopt .. ",vertical"

-- Allow hiding unsaved buffers
vim.o.hidden = true

-- Ignore case in searches
vim.o.ignorecase = true

-- Use case-sensitive when searches contain uppercase
vim.o.smartcase = true

-- Show incremental search
vim.o.inccommand = "nosplit"

-- Don't insert extra spaces after . when joining
vim.o.joinspaces = false

-- Define visible whitespace characters
vim.o.listchars = "tab:→·,trail:·,nbsp:■"

-- Disable mouse
vim.o.mouse = ""

-- Keep 10 lines above and below cursor
vim.o.scrolloff = 10

-- Keep 5 lines on either side of cursor
vim.o.sidescrolloff = 5

-- Disable :autocmd in files not owned by user
vim.o.secure = true

-- Indent to closest shiftwidth
vim.o.shiftround = true

-- Spaces used for tab stop
vim.o.shiftwidth = 2

vim.o.shortmess = vim.o.shortmess .. "A" -- Hide swap file warnings
vim.o.shortmess = vim.o.shortmess .. "I" -- Hide splash screen
vim.o.shortmess = vim.o.shortmess .. "W" -- Hide file written message
vim.o.shortmess = vim.o.shortmess .. "a" -- Abbreviate various messages
vim.o.shortmess = vim.o.shortmess .. "c" -- Hide completion messages

-- Hide mode
vim.o.showmode = false

-- Open new horizontal splits below
vim.o.splitbelow = true

-- Open new vertical splits to the right
vim.o.splitright = true

-- Lower updatetime time for hold events
vim.o.updatetime = 300

-- Set :grep program to `rg`
vim.o.grepprg = "rg --vimgrep --no-heading"

-- Set format for `rg`
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"

-- Set some general sessions options that should help with auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Wrap on linebreak when wrap is on
vim.wo.linebreak = true

-- Don't wrap lines
vim.wo.wrap = false

-- Show whitespace characters
vim.wo.list = true

-- Enable line numbering by default
vim.wo.number = false

-- Enable relative line numbering by default
vim.wo.relativenumber = false

-- Always show sign column
vim.wo.signcolumn = "yes"

-- Expand tabs into spaces
vim.bo.expandtab = true

-- Smart join comment lines
vim.bo.formatoptions = vim.o.formatoptions .. "j"

-- Set tab stops to 2
vim.bo.tabstop = 2
