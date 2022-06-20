vim.cmd([[
  nnoremap <Leader><Leader> :Files<CR>
  nnoremap <Leader>fc :Commands<CR>
  nnoremap <Leader>fd :Directories<CR>
  nnoremap <Leader>fgb :BCommits<CR>
  nnoremap <Leader>fgl :Commits<CR>
  nnoremap <Leader>fgs :GFiles?<CR>
  nnoremap <Leader>fh :Helptags<CR>
  nnoremap <Leader>fl :Lines<CR>
  nnoremap <Leader>fm :Maps<CR>
  nnoremap <Leader>fs :Snippets<CR>

  command! -bang Directories call fzf#run(fzf#wrap({'source': 'find * -type d'}))

  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'FloatBorder', 'border': 'rounded' } }
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Comment'],
    \ 'bg':      ['bg', 'NormalFloat'],
    \ 'hl':      ['fg', 'Normal'],
    \ 'fg+':     ['fg', 'Normal'],
    \ 'bg+':     ['bg', 'Normal'],
    \ 'hl+':     ['fg', 'Identifier'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Identifier'],
    \ 'pointer': ['fg', 'Identifier'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
]])
