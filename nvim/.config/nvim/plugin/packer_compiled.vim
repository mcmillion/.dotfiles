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
  ["ayu-vim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  everforest = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/everforest"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/iceberg.vim"
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
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/mlm/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  }
}

-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.lualine\frequire\0", "config", "lualine.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
