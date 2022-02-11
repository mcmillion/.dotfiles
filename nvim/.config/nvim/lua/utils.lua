local utils = {}

function utils.noremap(mode, map, command)
  vim.api.nvim_set_keymap(mode, map, command, { noremap = true })
end

function utils.silent_noremap(mode, map, command)
  vim.api.nvim_set_keymap(mode, map, command, { noremap = true, silent = true })
end

return utils
