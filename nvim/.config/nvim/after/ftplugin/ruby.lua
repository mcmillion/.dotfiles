vim.keymap.set(
  "n",
  "<c-b>",
  ":FloatermNew --width=0.8 --height=0.8 bundle exec rspec<cr>",
  { noremap = true, silent = true }
)
