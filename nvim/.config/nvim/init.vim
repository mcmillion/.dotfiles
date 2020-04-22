" vim:fdm=marker

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

" Theme / Layout
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'

" Editing Extensions
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Tmux Integration
Plug 'benmills/vimux', { 'for': 'ruby' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test', { 'for': 'ruby' }
Plug 'tmux-plugins/vim-tmux-focus-events'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Support
Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app & yarn install'  }
Plug 'jparise/vim-graphql'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" Search / Fuzzy Finding / File Management / Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wincent/ferret'

" Completion / Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-solargraph', 'coc-snippets']

" Misc
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-obsession'

call plug#end()

" }}}

" General Settings {{{

set background=dark                     " Color scheme background
set diffopt+=vertical                   " Force vertical diffs
set expandtab                           " Auto-expand tabs into spaces
set exrc                                " Enable local project .nimvrc files
set formatoptions+=j                    " Smart join comment lines
set formatoptions-=c                    " Don't auto-wrap comments
set hidden                              " Hide buffers without having to save
set ignorecase                          " Ignore case in searches by default
set inccommand=nosplit                  " Highlight regex replace as it happens in split
set linebreak                           " Wrap on linebreak characters when wrap is on
set list                                " Turn on whitespace characters
set listchars=tab:→·,trail:·,nbsp:■     " Define visible whitespace characters
set nobackup                            " Disable backups
set nojoinspaces                        " Don't insert extra spaces after . when joining
set nonumber                            " Turn off line numbering
set noswapfile                          " Turn off inline swapfiles
set nowrap                              " Turn off line wrapping
set nowritebackup                       " Really disable backups
set scrolloff=10                        " Keep 10 lines above and below cursor when scrolling
set secure                              " Disable :autocmd in files not owned by user
set shell=/usr/local/bin/zsh            " Make Vim work nicely with ZSH/RVM
set shiftround                          " Indent to the closest shiftwidth
set shiftwidth=2                        " Set tab stops for reindent operations
set shortmess+=A                        " Hide swap file warnings
set shortmess+=I                        " Hide splash screen
set shortmess+=W                        " Hide file written message
set shortmess+=a                        " Abbreviate various messages
set shortmess+=c                        " Hide completion messages
set sidescrolloff=5                     " Keep 10 columns left or right of cursor when scrolling
set signcolumn=yes                      " Always show signcolumn
set smartcase                           " Use case-sensitive when searches contain uppercase
set splitbelow                          " Open new horizontal splits below
set splitright                          " Open new vertical splits on the right
set tabstop=2                           " Set tab stops to 2
set textwidth=0                         " Disabled auto wrapping
set undofile                            " Turn on persistent undo
set undolevels=1000                     " Maximum number of changes that can be undone
set undoreload=10000                    " Maximum number lines to save for undo on a buffer reload
set updatetime=300                      " Tweak updatetime for better vim-gitgutter/coc

set guicursor=a:block-blinkwait250-blinkon250

" }}}

" Color Scheme Settings {{{

let g:gruvbox_bold =1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_termcolors = 16
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_invert_selection = 0
colorscheme gruvbox
highlight HighlightedyankRegion ctermfg=15 ctermbg=6
highlight CursorLine ctermbg=236

" }}}

" Misc Functions and Autocommands {{{

" Automatically trim trailing whitespace
fun! <SID>StripTrailingWhitespaces()
  let view = winsaveview()
  %s/\s\+$//e
  call winrestview(view)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Sync syntax from start of file automatically
autocmd BufEnter * :syntax sync fromstart

" autoresize pane layout when terminal resizes
autocmd VimResized * :wincmd =

" Cursorline in active pane
 augroup CursorLine
   au!
   au VimEnter,WinEnter,BufWinEnter,FocusGained * setlocal cursorline
   au WinLeave,FocusLost * setlocal nocursorline
 augroup END

" }}}

" General Mappings {{{

let mapleader="\<Space>"

" Edit configuration
nnoremap <silent> <Leader>xe :e $MYVIMRC<CR>

" Refresh all the important things that sometimes need refreshing
nnoremap <silent> <Leader>xr :so $MYVIMRC<CR>:checktime<CR>:redraw!<CR>

" Remove last search highlighting
nnoremap <silent> <Leader>h :noh<CR>

" Split line
nnoremap K i<CR><Esc>

" Use :w!! to force write files with sudo
cnoremap <silent> w!! %!sudo tee > /dev/null %

" Save and Quit easier
nnoremap <silent> WW :w<CR>
nnoremap <silent> QQ :q<CR>

" Disable ex mode
nnoremap <silent> Q <Nop>

" Disable undo text in insert
inoremap <c-u> <Nop>

" Keep search in the middle of the screen
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" Quick window resizing
nnoremap <silent> <Leader><Up> :5wincmd +<CR>
nnoremap <silent> <Leader><Down> :5wincmd -<CR>
nnoremap <silent> <Leader><Left> :5wincmd <<CR>
nnoremap <silent> <Leader><Right> :5wincmd ><CR>

" Close Quickfix / Hide Highlight
nnoremap <silent> <Leader>qx :cclose<CR>:noh<CR>

" Panes / Tabs
nnoremap <silent> <Leader>- :vsplit %:h<CR>
nnoremap <silent> <Leader>_ :split %:h<CR>
nnoremap <silent> <Leader>= :tab split %:h<CR>
nnoremap <silent> <Leader>+ :tabclose<CR>

" Yank to end of line because consistency makes sense
nnoremap <silent> Y y$

" Substitute current word
nnoremap <Leader>s :s/<C-r><C-w>//g<Left><Left>
nnoremap <Leader>S :%s/<C-r><C-w>//g<Left><Left>
xnoremap <Leader>s :s///g<Left><Left><Left>

" Better Changle Global
nnoremap <silent> c* *Ncgn

" }}}

" CoC {{{

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" }}}

" Fugitive {{{

nnoremap <Leader>gs :vertical Gstatus<CR>
nnoremap <Leader>gd :Gdiffsplit!<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gpu :Git push<CR>
nnoremap <Leader>gpf :Git push --force-with-lease<CR>
nnoremap <Leader>gpl :Git pull --rebase<CR>
nnoremap <Leader>grc :Git rebase --continue<CR>
nnoremap <Leader>gra :Git rebase --abort<CR>

" }}}

" FZF {{{

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

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" }}}

" Gitgutter {{{

nnoremap <Leader>ggu :GitGutterUndoHunk
nnoremap <Leader>ggs :GitGutterStageHunk

" }}}

" Lightline {{{

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'git_branch', 'filename' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \   ]
  \ },
  \ 'inactive': {
  \   'right': [ ]
  \ },
  \ 'component_function': {
  \   'git_branch': 'FugitiveHead',
  \ },
  \ 'mode_map': {
  \   'n' : 'N',
  \   'i' : 'I',
  \   'R' : 'R',
  \   'v' : 'V',
  \   'V' : 'VL',
  \   "\<C-v>": 'VB',
  \   'c' : 'C',
  \   's' : 'S',
  \   'S' : 'SL',
  \   "\<C-s>": 'SB',
  \   't': 'T',
  \ },
\ }

" }}}

" Markdown {{{

let g:vim_markdown_folding_disabled = 1

" }}}

" Markdown Preview {{{

let g:mkdp_auto_close = 0

" }}}

" Ruby / Rails {{{

nnoremap <Leader>ra :A<CR>
nnoremap <Leader>rA :AV<CR>
nnoremap <Leader>rr :R<CR>
nnoremap <Leader>rR :RV<CR>
nnoremap <Leader>rk :Rake<CR>

" }}}

" Test {{{

let test#strategy = "vimux"
let test#ruby#rspec#executable = 'bundle exec rspec'
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>

" }}}
