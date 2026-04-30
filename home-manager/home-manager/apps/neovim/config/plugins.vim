" == PLUGINS ===================================================================
" Automatically install junegunn/vim-plug
" ----------------------------------------------------------
let vim_plug = getenv('HOME') . '/.config/nvim' . '/autoload/plug.vim'
if empty(glob(vim_plug))
  silent execute '!curl -fLo '.vim_plug.' --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
" ----------------------------------------------------------
call plug#begin()

" colorscheme
" ----------------------------------------------------------
Plug 'Tsuzat/NeoSolarized.nvim'

" Golang
" ----------------------------------------------------------
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" HCL (Hashicorp Configuration Language)
" ----------------------------------------------------------
Plug 'hashivim/vim-terraform'

" D2lang
" ----------------------------------------------------------
Plug 'terrastruct/d2-vim'

" Rust
" ----------------------------------------------------------
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'

" List ends here. Plugins become visible to Vim after this call.
" ----------------------------------------------------------
call plug#end()
