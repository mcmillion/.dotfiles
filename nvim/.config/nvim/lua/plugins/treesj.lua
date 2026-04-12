return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  opts = {
    use_default_keymaps = false,
  },

  keys = {
    { "<Leader>m", ":TSJToggle<CR>", desc = "Toggle split/join" },
    { "<Leader>j", ":TSJJoin<CR>", desc = "Join lines" },
    { "<Leader>k", ":TSJSplit<CR>", desc = "Split lines" },
  },
}
