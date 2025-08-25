return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "zbirenbaum/copilot-cmp",
    },

    config = function()
      local cmp = require("cmp")

      cmp.setup({
        window = {
          completion = {
            border = "single",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            col_offset = -3,
            side_padding = 1,
          },
          documentation = {
            border = "single",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
        },
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "copilot", priority = 100, max_item_count = 3 },
          { name = "path", priority = 50 },
          { name = "buffer", priority = 25 },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          format = function(entry, vim_item)
            -- Don't truncate copilot completions, but truncate others
            if entry.source.name ~= "copilot" then
              local max_width = 80
              if string.len(vim_item.abbr) > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
              end
            end
            
            vim_item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              path = "[File]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
            })[entry.source.name]
            vim_item.dup = ({
              buffer = 0,
              path = 0,
              nvim_lsp = 0,
            })[entry.source.name] or 0
            return vim_item
          end,
        },
      })
    end,
  },
}
