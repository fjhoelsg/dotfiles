""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Vim Config                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vimrc
if exists('&inccommand')
  set inccommand=nosplit        " Incremental substitution without second panel
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &compatible
  set nocompatible
endif

let $nvimDir = expand($HOME.'/.config/nvim')
let $autoloadPlug = $nvimDir.'/autoload/plug.vim'

if ! filereadable($autoloadPlug)
  echo "Downloading junegunn/vim-plug..."
  silent !curl -SsfLo $autoloadPlug --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin($nvimDir.'/plugged')
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
call plug#end()                             

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Airline                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neocomplete                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
set completeopt-=preview
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Tab completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Go                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Replace grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Replace CtrlP search
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'
  let g:ctrlp_use_caching = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on                             " Syntax processing
set t_Co=256                          " Use 256 colors
set background=dark                   " Dark background

" Remove terminal background
highlight Normal ctermbg=none
highlight NonText ctermbg=none
autocmd VimEnter * highlight Normal ctermbg=none
autocmd VimEnter * highlight NonText ctermbg=none

let g:onedark_color_overrides = {
      \ "black": {"gui": "#000000", "cterm": "0", "cterm16": "0" },
      \ "cursor_grey": {"gui": "#0a0a0a", "cterm": "0", "cterm16": "0" },
      \ "visual_grey": {"gui": "#000000", "cterm": "0", "cterm16": "0" },
\}

autocmd ColorScheme * highlight Visual
      \ cterm=NONE ctermbg=White ctermfg=Black
      \ gui=NONE guibg=#e91e63 guifg=#ffffff

silent! colorscheme onedark           " Colorscheme
