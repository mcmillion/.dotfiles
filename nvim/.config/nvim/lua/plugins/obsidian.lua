return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.obsidian/main/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.obsidian/main/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/.obsidian/main",
      },
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    legacy_commands = false,

    checkbox = {
      order = { " ", "x" },
    },

    frontmatter = {
      enabled = false,
    },

    ui = {
      enable = false,
    },
  },

  keys = {
    { "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Find note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search vault" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Tags" },
    { "<leader>ol", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox" },
  },
}
