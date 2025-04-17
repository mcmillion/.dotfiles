return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",

  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load()

    local ls = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.locally_jumpable(1) then
        ls.jump(1)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", true)
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.locally_jumpable(-1) then
        ls.jump(-1)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", true)
      end
    end, { silent = true })
  end,
}
