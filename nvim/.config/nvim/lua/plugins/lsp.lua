-- Diagnostic Icon Settings
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "ℹ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

function on_attach(client, bufnr)
  -- Hover information
  vim.keymap.set("n", "grh", "<Cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr, noremap = true, silent = true })

  -- Go to previous diagnostic
  vim.keymap.set(
    "n",
    "[d",
    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

  -- Go to next diagnostic
  vim.keymap.set(
    "n",
    "]d",
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

  -- Open diagnostic in float
  vim.keymap.set(
    "n",
    "grd",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )
end

return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      -- Typescript
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        root_markers = { "package.json" },
        single_file_support = false,
      })
      vim.lsp.enable("ts_ls")

      -- ESLint
      local function eslint_fix_all(opts)
        opts = opts or {}
        local bufnr = opts.bufnr or 0
        local eslint_client = vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]
        if not eslint_client then
          return
        end

        local params = {
          command = "eslint.applyAllFixes",
          arguments = {
            {
              uri = vim.uri_from_bufnr(bufnr),
              version = vim.lsp.util.buf_versions[bufnr],
            },
          },
        }

        if opts.sync then
          eslint_client.request_sync("workspace/executeCommand", params, nil, bufnr)
        else
          eslint_client.request("workspace/executeCommand", params, nil, bufnr)
        end
      end

      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_create_user_command(bufnr, "EslintFixAll", function()
            eslint_fix_all({ sync = true, bufnr = bufnr })
          end, { desc = "Fix all eslint problems for this buffer" })

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          on_attach(client, bufnr)
        end,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
          "svelte",
          "astro",
          "json",
        },
      })
      vim.lsp.enable("eslint")

      -- Tailwind
      vim.lsp.config("tailwindcss", {
        on_attach = on_attach,
        root_markers = { "package.json" },
      })
      vim.lsp.enable("tailwindcss")

      -- Deno
      vim.lsp.config("denols", {
        root_markers = { "deno.json", "deno.jsonc" },
        init_options = {
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
                ["https://cdn.nest.land"] = true,
                ["https://crux.land"] = true,
              },
            },
          },
        },
        on_attach = on_attach,
      })
      vim.lsp.enable("denols")

      -- GDScript
      vim.lsp.config("gdscript", {
        settings = {},
        on_attach = on_attach,
      })
      vim.lsp.enable("gdscript")
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
            },
          },
        },
        tools = {
          inlay_hints = {
            only_current_line = true,
          },
        },
      }
    end,
  },
}
