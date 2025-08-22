local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

return {
  "nvim-lualine/lualine.nvim",

  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(s)
            return s:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          "branch",
          fmt = function(s)
            if string.len(s) < 25 then
              return s
            else
              return s:sub(1, 24) .. "…"
            end
          end,
        },
        {
          "diff",
          source = diff_source,
          diff_color = {
            added = { fg = "#9FDACC" },
            modified = { fg = "#B7C4FF" },
            removed = { fg = "#FFC0C5" },
          },
        },
        {
          "diagnostics",
          symbols = {
            error = "✘",
            warn = "▲",
            info = "⚑",
            hint = "ℹ",
          },
        },
      },
      lualine_c = { { "filename", path = 1, shorting_target = 30 } },
      lualine_x = {
        {
          "filetype",
          icons_enabled = false,
          fmt = function(s)
            if s == "javascript" then
              return "js"
            elseif s == "javascriptreact" then
              return "jsx"
            elseif s == "typescript" then
              return "ts"
            elseif s == "typescriptreact" then
              return "tsx"
            else
              return s
            end
          end,
        },
      },
      lualine_y = {},
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1, shorting_target = 30 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
