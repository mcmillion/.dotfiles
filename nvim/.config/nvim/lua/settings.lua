-- Global Options
local o = vim.o
o.background = 'dark'                      -- Dark mode
o.backup = false                           -- Disable backups
o.diffopt = o.diffopt .. ',vertical'       -- Force diff to vertical
o.hidden = true                            -- Allow hiding unsaved buffers
o.ignorecase = true                        -- Ignore case in searches
o.inccommand = 'nosplit'                   -- Show incremental search
o.joinspaces = false                       -- Don't insert extra spaces after . when joining
o.listchars = 'tab:→·,trail:·,nbsp:■'      -- Define visible whitespace characters
o.mouse = ''                               -- Disable mouse
o.scrolloff = 10                           -- Keep 10 lines above and below cursor
o.secure = true                            -- Disable :autocmd in files not owned by user
o.shiftround = true                        -- Indent to closest shiftwidth
o.shiftwidth = 2                           -- Spaces used for tab stop
o.shortmess = o.shortmess .. 'A'           -- Hide swap file warnings
o.shortmess = o.shortmess .. 'I'           -- Hide splash screen
o.shortmess = o.shortmess .. 'W'           -- Hide file written message
o.shortmess = o.shortmess .. 'a'           -- Abbreviate various messages
o.shortmess = o.shortmess .. 'c'           -- Hide completion messages
o.showmode = false                         -- Hide mode
o.sidescrolloff = 5                        -- Keep 5 lines on either side of cursor
o.smartcase = true                         -- Use case-sensitive when searches contain uppercase
o.splitbelow = true                        -- Open new horizontal splits below
o.splitright = true                        -- Open new vertical splits to the right
o.swapfile = false                         -- Disable swapfile
o.termguicolors = true                     -- 24-bit color
o.undofile = true                          -- Turn on persistent undo
o.updatetime = 300                         -- Lower updatetime time for hold events
o.writebackup = false                      -- Really disable backups

-- Window-Local Options
local wo = vim.wo
wo.linebreak = true                        -- Wrap on linebreak when wrap is on
wo.list = true                             -- Show whitespace characters
wo.number = true                           -- Enable line numbering by default
wo.relativenumber = true                   -- Enable relative line numbering by default
wo.signcolumn = 'yes'                      -- Always show sign column
wo.wrap = false                            -- Don't wrap lines

-- Buffer Options
local bo = vim.bo
bo.expandtab = true                        -- Expand tabs into spaces
bo.formatoptions = o.formatoptions .. 'j'  -- Smart join comment lines
bo.swapfile = false                        -- Disable swapfile (here as well)
bo.undofile = true                         -- Turn on persistent undo (here as well)
bo.tabstop = 2                             -- Set tab stops to 2

o.grepprg = 'rg --vimgrep --no-heading'    -- Set :grep program to `rg`
o.grepformat = '%f:%l:%c:%m,%f:%l:%m'      -- Set format for `rg`

-- Set some general sessions options that should help with auto-session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
