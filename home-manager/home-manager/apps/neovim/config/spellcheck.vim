" == SPELLCHECK ================================================================
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
