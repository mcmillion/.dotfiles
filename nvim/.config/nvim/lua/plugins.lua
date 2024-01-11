vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Syntax Highlighting / Formatting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('config.colorizer') end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('config.indent-blankline') end
  }
  use {
    'vim-autoformat/vim-autoformat',
    config = function() require('config.vim-autoformat') end
  }

  -- Movement
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function() require('config.treesitter-textobjects') end
  }
  use {
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    config = function() require('config.treesj') end,
  }

  -- Statusline / Tabline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.lualine') end
  }

  -- LSP / Completion
  use {
    'neovim/nvim-lspconfig',
    config = function() require('config.lspconfig') end
  }
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
  use {
    'simrat39/rust-tools.nvim',
    config = function() require('config.rust-tools') end
  }
  use {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function() require("copilot").setup() end, 100)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function() require("config.copilot-cmp") end
  }
  use {
    'onsails/diaglist.nvim',
    config = function() require('config.diaglist') end
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require("config.null-ls") end
  }

  -- File Navigation / Search
  use { 'ibhagwan/fzf-lua',
    config = function() require('config.fzf-lua') end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'wincent/ferret',
    config = function() require('config.ferret') end
  }

  -- Tmux / Terminal Integration
  use {
    'numToStr/Navigator.nvim',
    config = function() require('config.navigator') end
  }
  use {
    'voldikss/vim-floaterm',
    config = function() require('config.vim-floaterm') end
  }

  -- Git Integration
  use {
    'tpope/vim-fugitive',
    config = function() require('config.fugitive') end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.gitsigns') end
  }

  -- Misc Utilities
  use {
    'andymass/vim-matchup',
    config = function() require('config.vim-matchup') end
  }
  use {
    'SirVer/ultisnips',
    config = function() require('config.ultisnips') end
  }
  use {
    'lambdalisue/suda.vim',
    config = function() require('config.suda') end
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-abolish'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use {
    'rmagatti/auto-session',
    config = function() require('config.auto-session') end
  }
  use {
    'davidgranstrom/nvim-markdown-preview',
    config = function() require('config.markdown-preview') end,
    ft = { 'markdown' }
  }
  use 'wakatime/vim-wakatime'
end)
