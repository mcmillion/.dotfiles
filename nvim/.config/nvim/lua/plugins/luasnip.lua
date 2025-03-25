return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",

  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load()

    local ls = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
  end,
}
