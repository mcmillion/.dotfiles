local utils = {}

function utils.noremap(mode, map, command)
  vim.api.nvim_set_keymap(mode, map, command, { noremap = true })
end

return utils