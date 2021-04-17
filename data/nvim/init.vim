" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" ----------------------------------------

" Solarized
Plug 'iCyMind/NeoSolarized'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" ----------------------------------------

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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

" Solarized
" set termguicolors " This seems to make the colors weird
set background=dark
colorscheme NeoSolarized


" vim 7.4 patch for logipat (cause Ex command :E to become ambiguous)
let g:loaded_logipat = 1

" remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" golang mappings
map gd :GoDef<ENTER>
map gb :GoDefPop<ENTER>
map gcv :GoCoverage<ENTER>
map gccc :GoCoverageClear<ENTER>
map grn :GoRename<ENTER>
map gip :GoImports<ENTER>

" spell check
setlocal spell spelllang=en_us
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
