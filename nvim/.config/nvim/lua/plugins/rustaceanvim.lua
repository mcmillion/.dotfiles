return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
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
}
