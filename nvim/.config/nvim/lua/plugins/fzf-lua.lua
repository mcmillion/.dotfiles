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
    { "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<CR>", desc = "Keymaps" },
    { "<leader><leader>", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files" },
    { "<leader>fd", "<cmd>lua require('fzf-lua').files({ cmd = 'find * -type d' })<CR>", desc = "Find directories" },
    { "<leader>fg", "<cmd>lua require('fzf-lua').git_commits()<CR>", desc = "Git commits" },
    { "<leader>fm", "<cmd>lua require('fzf-lua').marks()<CR>", desc = "Marks" },
    { "gra", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Code actions" },

    { "<leader>dc", "<cmd>lua require('fzf-lua').dap_commands()<CR>", desc = "DAP commands" },
    { "<leader>db", "<cmd>lua require('fzf-lua').dap_breakpoints()<CR>", desc = "DAP breakpoints" },
  },
}
