" == PLUGIN: GOLANG ============================================================
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
