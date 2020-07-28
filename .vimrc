""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","                     " Change leader mapping
filetype off                          " Enable file type
set autoread                          " Read file when changed
set history=1000                      " Max history lines
set nocompatible                      " Use improved
set updatetime=1000                   " Set to 1000 to avoid plugin glitches
set cursorline                        " Highlight current line
set backspace=indent,eol,start        " Backspace behavior
set hidden                            " Allow background buffers
set laststatus=2                      " Always show status line
set lazyredraw                        " Redraw only when needed
set nojoinspaces                      " Do not join spaces
set nostartofline                     " Do not reset to start of line
set nowrap                            " Do not wrap lines
set number                            " Show line numbers
set numberwidth=5                     " Change gutter width
set relativenumber                    " Use relative numbers
set scrolloff=5                       " Keep rows above and below the cursor
set sidescrolloff=5                   " Keep columns to the right of the cursor
set sidescroll=5                      " Scroll when cursor moves off screen
set ruler                             " Show current position
set showcmd                           " Show command on bottom
set showmatch                         " Highlight matching braces
set showmode                          " Show current mode
set ttyfast                           " Fast terminal
set wildmenu                          " Use visual autocomplete
set wildmode=longest,list,full        " Autocomplete options
set timeoutlen=1000 ttimeoutlen=0     " Remove Esc key deley
set clipboard=unnamedplus             " Use system clipboard
autocmd BufWritePre * :%s/\s\+$//e    " Remove trailing spaces on write
set splitbelow                        " Open split panes at the bottom
set splitright                        " Open split panes to the right
set diffopt+=vertical                 " Use vertial split for diffs

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:netrw_banner=0                  " Remove banner
let g:netrw_liststyle=3               " Change preferred view type
let g:netrw_browse_split=4            " Open files in previous window
let g:netrw_altv = 1                  " Open files to the right
let g:netrw_winsize=20                " Windows size


" Fix Ctrl-l movement
augroup netrw_mappings
  autocmd!
  autocmd filetype netrw noremap <buffer> <C-l> <C-w>l
augroup END

" Toggle
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
        wincmd l
    endif
endfunction

" Close Netrw if it's the only buffer open
function! WindowEnterHandler()
  if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix'
    :exit
  endif
endfun
autocmd WinEnter * :call WindowEnterHandler()

" Open on launch
function! NetrwOnBufferOpen()
  " Do not open if already open
  if exists('b:noNetrw')
    return
  endif
  " When opening a directory
  if winnr('$') == 1 && getbufvar(winbufnr(1), "&filetype") == ''
    " Change working directory
    :cd %:p:h
    call ToggleNetrw()
    " Replace additional netwr pane with empty buffer
    :new
    wincmd k
    :exit
    wincmd h
  endif
endfun

" Project drawer configuration
augroup ProjectDrawer
  autocmd!
  " Do not launch Netrw for certain files
  autocmd VimEnter */.git/COMMIT_EDITMSG let b:noNetrw=1
  " Auto launch Netrw
  autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Errors                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set noerrorbells                      " Disable error bells
set visualbell                        " Enable visual bell to remove audio bell
set t_vb=                             " Remove visual bell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup                          " Disable backups
set nowritebackup                     " Disable write backup"
set noswapfile                        " Disable swap file"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8                    " Default encoding
set fileencoding=utf-8                " File encoding
set ffs=unix,dos,mac                  " Use UNIX file type
set eol                               " Add newline at the end of files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent                        " Automatic indentation
set expandtab                         " Use spaces
set shiftwidth=2                      " Shift width
set smarttab                          " Smart tabs
set softtabstop=2                     " Number of spaces per TAB when editing
set tabstop=2                         " Spaces used to display TAB

if has("autocmd")
  autocmd FileType make set noexpandtab
  autocmd Filetype gitcommit setlocal spell textwidth=72
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch                          " Highlight matches
set ignorecase                        " Ignore case
set incsearch                         " Incremental search
set magic                             " Allow regular expressions
set smartcase                         " Use smart casing
set wrapscan                          " Wrap around

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings                                                                 "
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
