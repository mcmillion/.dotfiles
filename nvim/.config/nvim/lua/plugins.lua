vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use { "wbthomason/packer.nvim", opt = true }

  use 'tpope/vim-vinegar'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('config.lualine') end
  }
end)
