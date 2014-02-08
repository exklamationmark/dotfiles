filetype plugin indent on

# indent with = 2 space
set expandtab
set tabstop=2
set shiftwidth=2

# show line number
set nu

# show rule
set ruler
set cursorline

# highlight search result
set hlsearch

# show matching brackets
set showmatch

# syntax highlighting
syntax enable

# encoding UTF-8 (Unicode)
set encoding=utf8

# no backup, since most file is in Git
set nobackup
set nowb
set noswapfile

# wrap text
set wrap

# forward search with space, backward search with Ctrl+Space
map <space> /
map <C-space> ?

# faster window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
