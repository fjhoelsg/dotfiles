""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
set autoread                          " Read file when changed
set history=1000                      " Max history lines
set nocompatible                      " Use improved
set updatetime=2000

filetype on                           " Disable file type
filetype plugin on                    " Enable file type plugin
filetype indent on                    " Use file specific indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

set t_Co=256                          " Use 256 colors
set background=dark                   " Dark background
colorscheme seti                      " Color scheme
syntax on                             " Syntax processing

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent                        " Automatic indentation
set expandtab                         " Use spaces
set shiftwidth=2                      " Shift width
set smarttab                          " Smart tabs
set softtabstop=2                     " Number of spaces per TAB when editing
set tabstop=2                         " Spaces used to display TAB

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

let mapleader = ","                   " Set new leader"
let g:mapleader = ","                 " Set new leader"
nmap <leader>w :w!<cr>                " Fast saving

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
