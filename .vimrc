" -----------------------------------------------------------------
" vundle settings
" -----------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" -----------------------------------------------------------------
" vim settings
" -----------------------------------------------------------------
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

" no backup, don't create a .vim file, since most file is in Git
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

" color scheme
set background=dark
colorscheme solarized
