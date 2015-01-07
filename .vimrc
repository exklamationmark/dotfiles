filetype plugin indent on

" indent with = 2 space
set expandtab
set tabstop=2
set shiftwidth=2

" show line numbers
set nu

" show ruler
set ruler
set cursorline

" highlight search result
set hlsearch

" show matching brackets
set showmatch

" syntax highlighting
syntax enable

" encoding UTF-8 (Unicode)
set encoding=utf8

" no backup, since most file is in Git
set nobackup
set nowb
set noswapfile

" wrap text
set wrap

" 100-char width
set colorcolumn=100

" forward search with space, backward search with Ctrl+Space
map <space> /
map <C-space> ?

" faster window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" editor's background
set background=dark

" lazyredraw for fast scrolling
set lazyredraw

" start Pathogen
silent! call pathogen#infect()
