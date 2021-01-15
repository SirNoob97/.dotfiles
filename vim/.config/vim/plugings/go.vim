" Go
" --- Syntax hightlight doesnt work ---

"let g:go_auto_sameids=1
"let g:go_auto_type_info=1
let g:go_decls_includes="func,type"
let g:go_list_type="quickfix"
let g:go_fmt_command="goimports"
let g:go_addtags_transform="camelcase"
let g:go_fmt_fail_silently=1
let g:go_fmt_autosave=0

inoremap <buffer> <NUL> <C-x><C-o>
inoremap <buffer> . .<C-x><C-o>

nnoremap <silent> gd :GoDef<cr>
nnoremap <silent> gy :GoDefType<cr>
nnoremap <silent> gr :GoDecls<cr>
nnoremap <silent> dr :GoDeclsDir<cr>

nnoremap <silent><leader>i :GoInfo<cr>
nnoremap <silent><leader>f :GoFmt<cr>
nnoremap <silent><leader>ml :GoMetaLinter<cr>
nnoremap <silent><leader>A :GoAlternate<cr>
nnoremap <silent><leader>rn :GoRename<cr>
vnoremap <silent><leader>ef :GoFreevars<cr>
nnoremap <silent><leader>n :cnext<CR>
nnoremap <silent><leader>p :cprevious<CR>
"au FileType go nnoremap  :cclose<CR>

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
