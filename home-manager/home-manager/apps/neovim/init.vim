" Automatically install junegunn/vim-plug
let vim_plug = getenv('HOME') . '/.config/nvim' . '/autoload/plug.vim'
if empty(glob(vim_plug))
  silent execute '!curl -fLo '.vim_plug.' --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins will be downloaded under the specified directory.
call plug#begin()

" Declare the list of plugins.
" ----------------------------------------

" Solarized
Plug 'iCyMind/NeoSolarized'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'hashivim/vim-terraform'

" D2 diagrams
Plug 'terrastruct/d2-vim'

" Rust
Plug 'rust-lang/rust.vim'
" let g:rustfmt_autosave = 1


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

" Solarized
" set termguicolors " This seems to make the colors weird
set background=dark
colorscheme NeoSolarized

" remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Go configs
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
map gd :GoDef<ENTER>
map gb :GoDefPop<ENTER>
map gcv :GoCoverage<ENTER>
map gccc :GoCoverageClear<ENTER>
map grn :GoRename<ENTER>
map gip :GoImports<ENTER>
augroup GoAutoCommands
  autocmd!
  autocmd BufWritePost *.go silent! !gci write --section standard --section default --section 'prefix(sigs.k8s.io,k8s.io)' --section 'prefix(github.ihs.demonware.net)' %:p
  autocmd BufWritePost *.go edit
  autocmd BufWritePost *.go redraw!
augroup END

" Rust config
let g:rustfmt_autosave = 1

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

" -----------------------------------------------------------------
" Build binary spell file from frequently used word list(s)
" so they don't show up as spelling errors"
" -----------------------------------------------------------------
" autocmd VimEnter * execute "set spellfile=".glob(&runtimepath, "spell/*.add", 0, 1)
function! RecompileSpell()
  for d in globpath(&runtimepath, "spell/*.add", 0, 1)
      execute "mkspell! " . fnameescape(d)
  endfor
endfunction
command! -nargs=0 RecompileSpell call RecompileSpell()

" Turn on spell check
setlocal spell spelllang=en_us
