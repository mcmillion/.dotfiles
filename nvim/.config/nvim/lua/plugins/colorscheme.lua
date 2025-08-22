return {
  "mcauley-penney/techbase.nvim",
  priority = 1000,

  opts = {
    hl_overrides = {
      Comment = { fg = "#5B6081" },
    },
  },

  init = function()
    vim.cmd.colorscheme("techbase")
  end,
}
