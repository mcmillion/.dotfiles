return {
  "pwntester/octo.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },

  cmd = "Octo",

  keys = {
    { "<leader>gho", "<cmd>Octo<cr>", desc = "(octo) Menu" },
    { "<leader>ghp", "<cmd>Octo pr list<cr>", desc = "(octo) PRs" },
    { "<leader>ghi", "<cmd>Octo issue list<cr>", desc = "(octo) Issues" },
    { "<leader>ghs", "<cmd>Octo search<cr>", desc = "(octo) Search" },
    { "<leader>ghr", "<cmd>Octo review start<cr>", desc = "(octo) Start review" },
    { "<leader>ghR", "<cmd>Octo review resume<cr>", desc = "(octo) Resume review" },
  },

  opts = {
    picker = "fzf-lua",
  },
}
