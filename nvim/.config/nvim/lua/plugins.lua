vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Syntax Highlighting / Formatting
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'cakebaker/scss-syntax.vim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('config.colorizer') end
  }
  use { 'lukas-reineke/indent-blankline.nvim', config = function() require('config.indent-blankline') end }
  use { 'vim-autoformat/vim-autoformat', config = function() require('config.vim-autoformat') end }

  -- Statusline / Tabline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end
  }

  -- LSP / Completion
  use { 'neovim/nvim-lspconfig', config = function() require('config.lspconfig') end }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
    config = function() require('config.nvim-cmp') end
  }
  use 'alexaandru/nvim-lspupdate'
  use 'tversteeg/registers.nvim'
  use { 'simrat39/rust-tools.nvim', config = function() require('config.rust-tools') end }

  -- File Navigation / Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() require('config.telescope') end
  }
  use 'wincent/ferret'

  -- Tmux / Terminal Integration
  use {
    'numToStr/Navigator.nvim',
    commit = '6bfcf7d',
    config = function() require('config.navigator') end
  }
  use 'voldikss/vim-floaterm'

  -- Git Integration
  use { 'tpope/vim-fugitive', config = function() require('config.fugitive') end }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.gitsigns') end
  }

  -- Linting / Testing
  use {
    "rcarriga/vim-ultest",
    requires = {"vim-test/vim-test"},
    run = ":UpdateRemotePlugins",
    config = function() require('config.vim-ultest') end
  }

  -- Misc Utilities
  use {
    'SirVer/ultisnips',
    config = function() require('config.ultisnips') end
  }
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'rmagatti/auto-session'
  use 'editorconfig/editorconfig-vim'
  use {
    'davidgranstrom/nvim-markdown-preview',
    config = function() require('config.markdown-preview') end,
    ft = { 'markdown' }
  }
  use 'wakatime/vim-wakatime'
end)
