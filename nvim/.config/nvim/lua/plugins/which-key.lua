return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      mappings = false,
    },
    spec = {
      { "<leader>d", group = "diff/debug" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>o", group = "obsidian" },
      { "<leader>R", group = "rest" },
      { "gr", group = "lsp" },
    },
  },
}
