utils = require('utils')
local silent_noremap = utils.silent_noremap

require("neotest").setup({
  adapters = {
    require("neotest-vitest")({
      filter_dir = function(name, rel_path, root)
        if name:match("^e2e") then
          return false
        else
          return name ~= "node_modules"
        end
      end,
    }),
    require("neotest-playwright").adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
        filter_dir = function(name, rel_path, root)
          if name:match("^e2e") then
            return true
          else
            return name ~= "node_modules"
          end
        end,
      }
    }),
  },
})

silent_noremap('n', '<leader>t', '<cmd>lua require("neotest").run.run()<cr>')
silent_noremap('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>')
silent_noremap('n', '<leader>tw', '<cmd>lua require("neotest").watch.toggle(vim.fn.expand("%")) <cr>')
silent_noremap('n', '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>')
