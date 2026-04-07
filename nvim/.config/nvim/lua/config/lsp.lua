-- Diagnostic config
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

-- Eslint auto-fix helper
local function eslint_fix_all(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or 0
  local client = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "eslint",
  })[1]
  if not client then
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
    client.request_sync(
      "workspace/executeCommand",
      params,
      nil,
      bufnr
    )
  else
    client.request(
      "workspace/executeCommand",
      params,
      nil,
      bufnr
    )
  end
end

-- Global LspAttach autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Keymaps
    vim.keymap.set("n", "grh", vim.lsp.buf.hover, {
      buffer = bufnr,
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "grd", vim.diagnostic.open_float, {
      buffer = bufnr,
      noremap = true,
      silent = true,
    })

    -- Eslint auto-fix on save
    if client.name == "eslint" then
      vim.api.nvim_buf_create_user_command(
        bufnr,
        "EslintFixAll",
        function()
          eslint_fix_all({ sync = true, bufnr = bufnr })
        end,
        { desc = "Fix all eslint problems for this buffer" }
      )

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end
  end,
})

-- Blink completion capabilities
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Enable servers
vim.lsp.enable({
  "ts_ls",
  "eslint",
  "tailwindcss",
  "denols",
  "marksman",
  "gdscript",
})
