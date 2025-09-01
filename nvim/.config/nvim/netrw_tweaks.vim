
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  noremap <buffer>% :call CreateFileAndOpen()<CR>
  nnoremap <buffer> <C-l> :NavigatorRight<CR>
endfunction

function! CreateFileAndOpen()
  let l:filename = input("Enter filename: ")
  if len(l:filename) == 0
    return -1
  end

  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  execute 'edit ' . b:netrw_curdir.'/'.l:filename
endfunction
