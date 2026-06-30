return {
  "lmilojevicc/herdr-splits.nvim",
  cond = vim.env.HERDR_ENV == "1",
  event = "VeryLazy",

  opts = {},

  keys = {
    { "<c-h>", function() require("herdr-splits").move_cursor_left() end, silent = true },
    { "<c-j>", function() require("herdr-splits").move_cursor_down() end, silent = true },
    { "<c-k>", function() require("herdr-splits").move_cursor_up() end, silent = true },
    { "<c-l>", function() require("herdr-splits").move_cursor_right() end, silent = true },
  },
}
