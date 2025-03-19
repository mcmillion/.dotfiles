return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },

  config = function()
    require("copilot").setup()

    require("copilot_cmp").setup({
      method = "getCompletionsCycling",
    })
  end,
}
