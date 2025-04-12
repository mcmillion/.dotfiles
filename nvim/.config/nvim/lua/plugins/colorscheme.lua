return {
  "ferdinandrau/carbide.nvim",
  priority = 1000,

  opts = {
    style = {
      gutter = "editor_extended",
      functions = { bold = true, italic = false },
      comments = { bold = false, italic = true },
    },

    scheme_overrides = function(colors, variant, style)
      return {
        GitSignsChange = { fg = colors.fgc_yellow },
        GitSignsChangeCul = { fg = colors.fgc_yellow },
      }
    end,
  },

  config = function(_, opts)
    require("carbide").setup(opts)
    require("carbide").apply()
  end,
}
