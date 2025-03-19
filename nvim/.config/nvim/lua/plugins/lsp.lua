-- Diagnostic Icon Settings
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Float Border Settings
local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

function on_attach(client, bufnr)
  -- Go to definition
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr, noremap = true, silent = true })

  -- Hover information
  vim.keymap.set(
    "n",
    "<leader>ll",
    "<Cmd>lua vim.lsp.buf.hover()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

  -- Go to implementation
  vim.keymap.set(
    "n",
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

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

  -- Rename
  vim.keymap.set(
    "n",
    "<leader>lrn",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

  -- References
  vim.keymap.set(
    "n",
    "<leader>lrf",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )

  -- Open diagnostic in float
  vim.keymap.set(
    "n",
    "<leader>ld",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { buffer = bufnr, noremap = true, silent = true }
  )
end

return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      local lspconfig = require("lspconfig")

      -- Typescript
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
      })

      -- ESLint
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
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

      -- Tailwind
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json"),
      })

      -- Deno
      lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
    end,
  },

  {
    "simrat39/rust-tools.nvim",

    opts = {
      tools = {
        inlay_hints = {
          only_current_line = true,
        },
      },
      server = {
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      },
    },
  },
}
