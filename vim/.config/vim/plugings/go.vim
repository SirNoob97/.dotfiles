" Go

"let g:go_auto_sameids = 1
"let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_fmt_fail_silently = 1

let g:go_fmt_autosave = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

nnoremap <silent> gd :GoDef<cr>
nnoremap <silent> gr :GoDecls<cr>
nnoremap <silent> dr :GoDeclsDir<cr>

nnoremap <silent><leader>f :GoFmt<cr>
nnoremap <silent><leader>i :GoInfo<cr>
nnoremap <silent><leader>ml :GoMetaLinter<cr>
nnoremap <silent><leader>A :GoAlternate<cr>
nnoremap <silent><leader>rn :GoRename<cr>
vnoremap <silent><leader>ef :GoFreevars<cr>
nnoremap <silent><leader>n :cnext<CR>
nnoremap <silent><leader>p :cprevious<CR>
"au FileType go nnoremap  :cclose<CR>
