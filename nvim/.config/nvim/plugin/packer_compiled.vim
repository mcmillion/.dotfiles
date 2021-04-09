" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/mlm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/mlm/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/mlm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/mlm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/mlm/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["auto-session"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24config.auto-session\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.lualine\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.colorizer\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17config.compe\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspupdate"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-lspupdate"
  },
  ["nvim-markdown-preview"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-markdown-preview"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["presence.nvim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/presence.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.telescope\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.ultisnips\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.fugitive\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-prettier"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.prettier\frequire\0" },
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-rails"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/opt/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.vim-test\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/opt/vim-test"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  },
  vimux = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vimux"
  }
}

-- Config for: ultisnips
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.ultisnips\frequire\0", "config", "ultisnips")
-- Config for: nvim-colorizer.lua
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.colorizer\frequire\0", "config", "nvim-colorizer.lua")
-- Config for: telescope.nvim
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.telescope\frequire\0", "config", "telescope.nvim")
-- Config for: vim-prettier
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.prettier\frequire\0", "config", "vim-prettier")
-- Config for: auto-session
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24config.auto-session\frequire\0", "config", "auto-session")
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.gitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.lualine\frequire\0", "config", "lualine.nvim")
-- Config for: vim-fugitive
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20config.fugitive\frequire\0", "config", "vim-fugitive")
-- Config for: nvim-compe
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17config.compe\frequire\0", "config", "nvim-compe")
-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.lspconfig\frequire\0", "config", "nvim-lspconfig")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0", "config", "nvim-treesitter")
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'vim-rails', 'vim-test'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
