vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>fd",
  "<cmd>lua require('fzf-lua').files({ cmd = 'find * -type d' })<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>fg",
  "<cmd>lua require('fzf-lua').git_commits()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('fzf-lua').grep()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>lca",
  "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ls",
  "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>",
  { noremap = true, silent = true }
)

require("fzf-lua").setup({
  winopts = {
    backdrop = 100,
    fullscreen = true,
    border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
    hl = {
      normal = "NormalFloat",
      border = "FloatBorder",
      search = "NormalFloat",
    },
    preview = {
      title = false,
      winopts = {
        number = false,
        cursorline = false,
      },
    },
  },
  fzf_opts = {
    ["--layout"] = false,
  },
  fzf_colors = {
    ["fg"] = { "fg", "Comment" },
    ["bg"] = { "bg", "NormalFloat" },
    ["hl"] = { "fg", "Normal" },
    ["fg+"] = { "fg", "Normal" },
    ["bg+"] = { "bg", "CursorLine" },
    ["hl+"] = { "fg", "Identifier" },
    ["info"] = { "fg", "Comment" },
    ["prompt"] = { "fg", "Identifier" },
    ["pointer"] = { "fg", "Identifier" },
    ["marker"] = { "fg", "Keyword" },
    ["spinner"] = { "fg", "Label" },
    ["header"] = { "fg", "Comment" },
    ["gutter"] = { "bg", "NormalFloat" },
  },
})
