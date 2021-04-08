vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use { "wbthomason/packer.nvim", opt = true }

  -- Syntax Highlighting
  use 'ayu-theme/ayu-vim'
  use 'cocopon/iceberg.vim/'
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'sainnhe/everforest'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end
  }

  -- Statusline / Tabline
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end
  }

  -- Misc Utilities
  use 'tpope/vim-vinegar'
end)
