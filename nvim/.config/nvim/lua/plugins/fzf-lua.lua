return {
  "ibhagwan/fzf-lua",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function(_, opts)
    require("fzf-lua").setup(opts)
    require("fzf-lua").register_ui_select()
  end,

  opts = {
    file_ignore_patterns = {
      "%.uid$",
    },
    winopts = {
      backdrop = 100,
      fullscreen = true,
      border = "single",
      preview = {
        title = false,
        winopts = {
          number = false,
          cursorline = false,
        },
      },
    },
    hls = {
      normal = "NormalFloat",
      preview_normal = "NormalFloat",
      border = "FloatBorder",
      preview_border = "FloatBorder",
      search = "NormalFloat",
      preview_search = "NormalFloat",
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
    marks = {
      marks = "%a",
    },
  },

  keys = {
    -- Fuzzy find all files
    { "<leader><leader>", "<cmd>lua require('fzf-lua').files()<CR>" },

    -- Fuzzy find directories and open in netrw
    { "<leader>fd", "<cmd>lua require('fzf-lua').files({ cmd = 'find * -type d' })<CR>" },

    -- Fuzzy find git commits (and optionally check out)
    { "<leader>fg", "<cmd>lua require('fzf-lua').git_commits()<CR>" },

    -- Fuzzy find marks
    { "<leader>fm", "<cmd>lua require('fzf-lua').marks()<CR>" },

    -- LSP Code actions
    { "gra", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>" },

    -- Workspace symbols
    { "<leader>ls", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>" },

    -- DAP
    { "<leader>dc", "<cmd>lua require('fzf-lua').dap_commands()<CR>" },
    { "<leader>db", "<cmd>lua require('fzf-lua').dap_breakpoints()<CR>" },
  },
}
