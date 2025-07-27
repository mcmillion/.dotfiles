return {
  "ibhagwan/fzf-lua",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function(_, opts)
    require("fzf-lua").setup(opts)
    require("fzf-lua").register_ui_select()
  end,

  opts = {
    winopts = {
      backdrop = 100,
      fullscreen = true,
      hls = {
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
  },

  keys = {
    -- Fuzzy find all files
    { "<leader><leader>", "<cmd>lua require('fzf-lua').files()<CR>" },

    -- Fuzzy find directories and open in netrw
    { "<leader>fd", "<cmd>lua require('fzf-lua').files({ cmd = 'find * -type d' })<CR>" },

    -- Fuzzy find git commits (and optionally check out)
    { "<leader>fg", "<cmd>lua require('fzf-lua').git_commits()<CR>" },

    -- LSP Code actions
    { "<leader>lca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>" },

    -- Workspace symbols
    { "<leader>ls", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>" },
  },
}
