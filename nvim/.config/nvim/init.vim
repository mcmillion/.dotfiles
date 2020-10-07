" vim:fdm=marker

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux', { 'for': 'ruby' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app & yarn install'  }
Plug 'janko-m/vim-test', { 'for': 'ruby' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'wincent/ferret'

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
set nonumber                            " Turn on line numbering
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
highlight LineNr ctermfg=239
highlight CursorLine ctermbg=236
highlight CursorLineNR ctermbg=236 ctermfg=243
highlight MatchParen ctermbg=239

" }}}

" Misc Functions and Autocommands {{{

" Automatically trim trailing whitespace
fun! <SID>StripTrailingWhitespaces()
  let view = winsaveview()
  %s/\s\+$//e
  call winrestview(view)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" autoresize pane layout when terminal resizes
autocmd VimResized * :wincmd =

" }}}

" General Mappings {{{

let mapleader="\<Space>"

" Edit configuration
nnoremap <silent> <Leader>xe :e $MYVIMRC<CR>

" Refresh all the important things that sometimes need refreshing
nnoremap <silent> <Leader>xr :so $MYVIMRC<CR>:AirlineRefresh<CR>:checktime<CR>:redraw!<CR>

" Remove last search highlighting
nnoremap <silent> <Leader>h :noh<CR>

" Split line
nnoremap K i<CR><Esc>

" Use :w!! to force write files with sudo
cnoremap <silent> w!! %!sudo tee > /dev/null %

" Disable ex mode
nnoremap <silent> Q <Nop>

" Disable undo text in insert
inoremap <c-u> <Nop>

" Keep search in the middle of the screen
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" Quicker mappings
nnoremap <silent> QQ :q<CR>
nnoremap <Leader>w :w<CR>

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

" Airline {{{

let g:airline_left_sep=''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_powerline_fonts=1
let g:airline_right_sep=''
let g:airline_theme='gruvbox'
let g:airline_inactive_collapse=1
let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_section_z = '%3p%% %l:%c '

let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tab_min_count = 1

" }}}

" ALE {{{

let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:airline#extensions#ale#error_symbol = '● '
let g:ale_sign_warning = '○'
let g:airline#extensions#ale#warning_symbol = '○ '
let g:ale_linter_aliases = {'jsx': 'css'}
highlight ALEErrorSign ctermfg=1 ctermbg=0
highlight ALEWarningSign ctermfg=3 ctermbg=0

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  for mode in keys(a:palette)
    let a:palette[mode]['airline_error'] = [ '#fdf6e3', '#b58900', 15, 1 ]
    let a:palette[mode]['airline_warning'] = [ '#fdf6e3', '#dc322f', 15, 3 ]
  endfor
endfunction

let g:ale_linters = {
\   'html': [],
\}

" Only enable Ruby linters if configuration files are present
function! SetAleBufferLinters()
  let ruby_linters = ["ruby"]

  if filereadable(".rubocop.yml") | :call add(ruby_linters, "rubocop") | endif
  if filereadable("rails_best_practices.yml") | :call add(ruby_linters, "rails_best_pratices") | endif
  if filereadable(".reek") | :call add(ruby_linters, "reek") | endif

  let b:ale_linters = {
  \   'ruby': ruby_linters,
  \}
endfunction

augroup AleGroup
  autocmd!
  autocmd FileType,BufEnter * call SetAleBufferLinters()
augroup END

" }}}

" Emmet {{{

let g:user_emmet_settings = {
\    "html": {
\        "quote_char": "'"
\    },
\    "javascript.jsx": {
\        "extends": "jsx",
\        "quote_char": "'"
\    }
\}

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

" Markdown Preview {{{

let g:mkdp_auto_close = 0

" }}}

" Prettier {{{

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync

" }}}

" Test {{{

let test#strategy = "vimux"
let test#ruby#rspec#executable = 'bundle exec rspec'
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>

" }}}

" Ultisnips {{{

let g:UltiSnipsExpandTrigger = "<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsEditSplit="vertical"

" }}}
