return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "andymass/vim-matchup",
  },
  build = ":TSUpdate",
  lazy = false,

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "comment",
        "cpp",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "lua",
        "regex",
        "ruby",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        disable = { "html" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      },
      matchup = {
        enable = true,
      },
    })
  end,
}
