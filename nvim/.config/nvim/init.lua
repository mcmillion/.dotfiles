require("config.settings")
require("config.lazy")
require("config.maps")
require("config.autocommands")
require("config.commands")

if vim.g.neovide then
  require("config.neovide")
end

vim.cmd("source ~/.config/nvim/netrw_tweaks.vim")
