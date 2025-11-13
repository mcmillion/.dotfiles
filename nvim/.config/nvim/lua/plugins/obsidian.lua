return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/Notes",
      },
    },
    picker = {
      name = "fzf-lua",
    },
  },
  keys = {
    { "<leader>go", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian quick switch" },
    { "<leader>gn", "<cmd>ObsidianNew<cr>", desc = "Obsidian new note" },
  },
}
