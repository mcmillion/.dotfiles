require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      set_jumps = true,
      include_surrounding_whitespace = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
      },

      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    },
  },
}
