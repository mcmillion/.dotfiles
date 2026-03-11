return {
  "dlyongemallo/diffview.nvim",

  keys = {
    {
      "<leader>dv",
      function()
        local lib = require("diffview.lib")
        if lib.get_current_view() then
          vim.cmd("DiffviewClose")
        else
          local base_branch = vim.fn.system(
            "git rev-parse --verify --quiet main "
              .. ">/dev/null 2>&1 && echo main || echo master"
          ):gsub("%s+", "")
          local merge_base = vim.fn.system(
            "git merge-base " .. base_branch .. " HEAD"
          ):gsub("%s+", "")
          vim.cmd("DiffviewOpen " .. merge_base)
        end
      end,
      desc = "Toggle branch diff vs main",
    },
    {
      "<leader>du",
      "<cmd>DiffviewOpen<cr>",
      desc = "Diff uncommitted changes only",
    },
    {
      "<leader>dh",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "File history for current file",
    },
  },

  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_mixed" },
    },
  },
}
