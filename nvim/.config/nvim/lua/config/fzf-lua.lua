vim.api.nvim_set_keymap('n', '<leader><leader>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fd',
  "<cmd>lua require('fzf-lua').files({ cmd = 'find * -type d' })<CR>",
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fg',
  "<cmd>lua require('fzf-lua').git_commits()<CR>",
  { noremap = true, silent = true })

require('fzf-lua').setup({
  winopts = {
    border = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
    hl = {
      normal = 'NormalFloat',
      border = 'FloatBorder',
      search = 'NormalFloat',
    },
    preview = {
      title = false,
      winopts = {
        nubmer = false,
        cursorline = false,
      },
    },
  },
  fzf_opts = {
    ['--layout'] = false,
  },
  fzf_colors = {
    ["fg"]      = { "fg", "Comment" },
    ["bg"]      = { "bg", "NormalFloat" },
    ["hl"]      = { "fg", "Normal" },
    ["fg+"]     = { "fg", "Normal" },
    ["bg+"]     = { "bg", "CursorLine" },
    ["hl+"]     = { "fg", "Identifier" },
    ["info"]    = { "fg", "Comment" },
    ["prompt"]  = { "fg", "Identifier" },
    ["pointer"] = { "fg", "Identifier" },
    ["marker"]  = { "fg", "Keyword" },
    ["spinner"] = { "fg", "Label" },
    ["header"]  = { "fg", "Comment" },
    ["gutter"]  = { "bg", "NormalFloat" },
  },
})
