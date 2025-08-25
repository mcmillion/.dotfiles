return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },

  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })

    require("copilot_cmp").setup({
      method = "getCompletionsCycling",
      formatters = {
        label = require("copilot_cmp.format").format_label_text,
        insert_text = require("copilot_cmp.format").format_insert_text,
      },
    })
  end,
}
