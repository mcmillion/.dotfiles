vim.keymap.set(
  "n",
  "<c-b>",
  ":FloatermNew --autoclose=0 --width=0.8 --height=0.8 cargo run<cr>",
  { noremap = true, silent = true }
)
