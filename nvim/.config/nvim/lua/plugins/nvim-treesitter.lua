return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = function()
      require("nvim-treesitter").update(
        require("nvim-treesitter").get_installed()
      )
    end,
    lazy = false,

    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
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
        "query",
        "regex",
        "ruby",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      local installed = require("nvim-treesitter").get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(p)
          return not vim.tbl_contains(installed, p)
        end)
        :totable()

      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

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
