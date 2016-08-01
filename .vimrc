""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                          " Enable file type
set autoread                          " Read file when changed
set history=1000                      " Max history lines
set nocompatible                      " Use improved
set updatetime=750                    " Set to 1000 to avoid plugin glitches
set cursorline                        " Highlight current line
set backspace=indent,eol,start        " Backspace behavior
set hidden                            " Allow background buffers
set laststatus=2                      " Always show status line
set lazyredraw                        " Redraw only when needed
set nojoinspaces                      " Do not join spaces
set nostartofline                     " Do not reset to start of line
set nowrap                            " Do not wrap lines
set number                            " Show line numbers
set relativenumber                    " Use relative numbers
set ruler                             " Show current position
set showcmd                           " Show command on bottom
set showmatch                         " Highlight matching braces
set showmode                          " Show current mode
set ttyfast                           " Fast terminal
set wildmenu                          " Use visual autocomplete
set timeoutlen=1000 ttimeoutlen=0     " Remove Esc key deley
autocmd BufWritePre * :%s/\s\+$//e    " Remove trailing spaces on write

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Errors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set noerrorbells                      " Disable error bell
set novisualbell                      " Disable visual bell
set t_vb=                             " Remove visual bell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup                          " Disable backups
set nowritebackup                     " Disable write backup"
set noswapfile                        " Disable swap file"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8                    " Default encoding
set fileencoding=utf-8                " File encoding
set ffs=unix,dos,mac                  " Use UNIX file type
set eol                               " Add newline at the end of files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Download colorschemes
if !isdirectory(glob("~/.vim/colors"))
  :silent execute '!git clone https://github.com/flazz/vim-colorschemes.git ~/.vim/tmp-colors'
  :silent execute '!mv ~/.vim/tmp-colors/colors ~/.vim/colors'
  :silent execute '!rm -rf ~/.vim/tmp-colors'
endif

" Set colorscheme
set t_Co=256                          " Use 256 colors
set background=dark                   " Dark background
highlight Normal ctermbg=none         " Remove terminal background for normal text
highlight NonText ctermbg=none        " Remove terminal background for empty text
colorscheme Tomorrow-Night-Eighties   " Color scheme
syntax on                             " Syntax processing

" Remove terminal background
autocmd VimEnter * highlight Normal ctermbg=none
autocmd VimEnter * highlight NonText ctermbg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent                        " Automatic indentation
set expandtab                         " Use spaces
set shiftwidth=2                      " Shift width
set smarttab                          " Smart tabs
set softtabstop=2                     " Number of spaces per TAB when editing
set tabstop=2                         " Spaces used to display TAB

" Length for git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch                          " Highlight matches
set ignorecase                        " Ignore case
set incsearch                         " Incremental search
set magic                             " Allow regular expressions
set smartcase                         " Use smart casing
set wrapscan                          " Wrap around

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ctrl to move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable arrow keys in Command mode
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>

" Disable arrow keys in Insert mode
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" Diable backspace and delete keys in Insert mode
inoremap <BS> <Nop>
inoremap <Del> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
set completeopt-=preview
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Tab completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Go
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
