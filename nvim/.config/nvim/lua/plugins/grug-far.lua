return {
  "MagicDuck/grug-far.nvim",

  opts = {
    debounceMs = 500,
    engines = {
      ripgrep = {
        extraArgs = "--hidden --glob !{.git,.next,node_modules}",
      },
    },
    windowCreationCommand = "vsplit",
    transient = false,
    folding = {
      enabled = true,
      foldlevel = 1,
    },
  },

  keys = {
    {
      "<leader>fr",
      function() require("grug-far").open() end,
      desc = "(grug) Search and replace",
    },
    {
      "<leader>fR",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "(grug) Search and replace (current file)",
    },
    {
      "<leader>fw",
      function()
        require("grug-far").open({
          prefills = { search = vim.fn.expand("<cword>") },
        })
      end,
      desc = "(grug) Search and replace (cursor word)",
    },
    {
      "<leader>fr",
      function() require("grug-far").with_visual_selection() end,
      mode = "x",
      desc = "(grug) Search and replace (selection)",
    },
  },
}
