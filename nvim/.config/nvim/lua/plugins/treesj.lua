return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  opts = {
    use_default_keymaps = false,
  },

  keys = {
    { "<Leader>m", ":TSJToggle<CR>" },
    { "<Leader>j", ":TSJJoin<CR>" },
    { "<Leader>k", ":TSJSplit<CR>" },
  },
}
