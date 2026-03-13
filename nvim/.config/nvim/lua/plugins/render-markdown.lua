return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    preset = "obsidian",
    anti_conceal = {
      enabled = true,
    },
    heading = {
      setext = false,
    },
    checkbox = {
      checked = {
        scope_highlight = "RenderMarkdownCheckedDim",
      },
    },
  },
}
