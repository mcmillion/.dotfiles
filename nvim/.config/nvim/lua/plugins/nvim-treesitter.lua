return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "comment",
          "cpp",
          "gdscript",
          "go",
          "graphql",
          "html",
          "http",
          "javascript",
          "json",
          "json5",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "regex",
          "ruby",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = args.match
          if ft == "html" then
            return
          end
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  {
    "andymass/vim-matchup",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}
