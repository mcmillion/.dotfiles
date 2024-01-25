local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd',
  filetypes = {
    "css",
    "graphql",
    "html",
    "json",
    "less",
    "markdown",
    "scss",
    "yaml",
  },
})
