-- global options
local o = vim.o
o.background = 'dark'                      -- Dark mode
o.backup = false                           -- Disable backups
o.diffopt = o.diffopt .. ',vertical'       -- Force diff to vertical
o.hidden = true                            -- Allow hiding unsaved buffers
o.ignorecase = true                        -- Ignore case in searches
o.inccommand = 'nosplit'                   -- Show incremental search
o.joinspaces = false                       -- Don't insert extra spaces after . when joining
o.listchars = 'tab:→·,trail:·,nbsp:■'      -- Define visible whitespace characters
o.scrolloff = 10                           -- Keep 10 lines above and below cursor
o.secure = true                            -- Disable :autocmd in files not owned by user
o.shiftround = true                        -- Indent to closest shiftwidth
o.shiftwidth = 2                           -- Spaces used for tab stop
o.shortmess = o.shortmess .. 'A'           -- Hide swap file warnings
o.shortmess = o.shortmess .. 'I'           -- Hide splash screen
o.shortmess = o.shortmess .. 'W'           -- Hide file written message
o.shortmess = o.shortmess .. 'a'           -- Abbreviate various messages
o.shortmess = o.shortmess .. 'c'           -- Hide completion messages
o.sidescrolloff = 5                        -- Keep 5 lines on either side of cursor
o.smartcase = true                         -- Use case-sensitive when searches contain uppercase
o.splitbelow = true                        -- Open new horizontal splits below
o.splitright = true                        -- Open new vertical splits to the right
o.termguicolors = true                     -- 24-bit color
o.undofile = true                          -- Turn on persistent undo
o.updatetime = 300                         -- Lower updatetime time for hold events
o.writebackup = false                      -- Really disable backups

-- window-local options
local wo = vim.wo
wo.linebreak = true                        -- Wrap on linebreak when wrap is on
wo.list = true                             -- Show whitespace characters
wo.number = true                           -- Enable line numbering
wo.signcolumn = 'yes'                      -- Always show sign column
wo.wrap = false                            -- Don't wrap lines

-- buffer options
local bo = vim.bo
bo.expandtab = true                        -- Expand tabs into spaces
bo.formatoptions = o.formatoptions .. 'j'  -- Smart join comment lines
bo.swapfile = false                        -- Disable swapfile
bo.undofile = true                         -- Turn on persistent undo (here as well)
bo.tabstop = 2                             -- Set tab stops to 2
