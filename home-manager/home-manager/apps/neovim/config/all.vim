" -----------------------------------------------------------------
" vim settings
" -----------------------------------------------------------------
" indent with = 2 space
set tabstop=4
set shiftwidth=4

" show line numbers
set nu

" show ruler
set ruler
set cursorline

" No fold by default
set foldmethod=syntax
set nofoldenable

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
set colorcolumn=80,100
set signcolumn=yes

" showcmd
set showcmd

" remap :E to :Explore. Otherwise, :E might be confused with :EditQuery
command! E Explore

" forward search with space, backward search with Ctrl+Space
map <space> /
map <C-space> ?

" faster window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" lazyredraw for fast scrolling
set lazyredraw

" horizontal and vertical separators
hi WinSeparator guifg=#cb4b16 " Solarized's orange
set laststatus=2 "one status line per panel
hi StatusLine guibg=#268bd2 guifg=#002b36 " of current panel
hi StatusLineNC guibg=#839496 guifg=#002b36 " of non-current panel

" remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" noremap <C-c>cs :set spell spelllang=en_us
" noremap <m> ]s
" noremap <M> [s
" noremap <C-n>s :set nospell
set spell
set spelllang=en
hi SpellBad cterm=underline ctermfg=125 ctermbg=187

" mergetool
" map mm ]c
" map mp [c

" vimdiff colors
hi DiffAdd      cterm=none ctermfg=112  ctermbg=none
hi DiffDelete   cterm=none ctermfg=160 ctermbg=none
hi DiffChange   cterm=none ctermfg=none ctermbg=236
hi DiffText     cterm=none ctermfg=221 ctermbg=none
