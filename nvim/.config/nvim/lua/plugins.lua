vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use { "wbthomason/packer.nvim", opt = true }

  -- Syntax Highlighting
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('config.colorizer') end
  }

  -- Statusline / Tabline
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end
  }

  -- File Navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() require('config.telescope') end
  }

  -- Tmux Integration
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'christoomey/vim-tmux-navigator'
  use {
    'vim-test/vim-test',
    requires = { 'benmills/vimux' },
    ft = { 'ruby' },
    config = function() require('config.vim-test') end
  }

  -- Git Integration
  use { 'tpope/vim-fugitive', config = function() require('config.fugitive') end }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.gitsigns') end
  }

  -- Misc Utilities
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use { 'tpope/vim-rails', ft = { 'ruby' } }
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'andweeb/presence.nvim'
  use { 'rmagatti/auto-session', config = function() require('config.auto-session') end }
  use 'editorconfig/editorconfig-vim'
end)
