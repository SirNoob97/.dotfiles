" Go
" --- Syntax hightlight doesnt work ---

"let g:go_auto_sameids=1
"let g:go_auto_type_info=1
"let g:go_addtags_transform="camelcase"
let g:go_decls_includes="func,type"
let g:go_list_type="quickfix"
let g:go_fmt_command="goimports"
let g:go_fmt_fail_silently=1
let g:go_fmt_autosave=0
let g:go_doc_popup_window = 1

function VimGo()
  inoremap <buffer> <NUL> <C-x><C-o>
  inoremap <buffer> . .<C-x><C-o>

  nnoremap <buffer> <silent> gd :GoDef<cr>
  nnoremap <buffer> <silent> gy :GoDefType<cr>
  nnoremap <buffer> <silent> gr :GoReferrers<cr>
  nnoremap <buffer> <silent> gi :GoDecls<cr>
  nnoremap <buffer> <silent> dr :GoDeclsDir<cr>

  nnoremap <buffer> <silent><leader>a :GoImports<cr>
  nnoremap <buffer> <silent><leader>i :GoInfo<cr>
  nnoremap <buffer> <silent><leader>f :GoFmt<cr>
  nnoremap <buffer> <silent><leader>ml :GoMetaLinter<cr>
  nnoremap <buffer> <silent><leader>A :GoAlternate<cr>
  nnoremap <buffer> <silent><leader>rn :GoRename<cr>
  vnoremap <buffer> <silent><leader>ef :GoFreevars<cr>
  nnoremap <buffer> <silent><leader>n :cnext<CR>
  nnoremap <buffer> <silent><leader>p :cprevious<CR>
  nnoremap <buffer> <silent><leader>q :cclose<CR>
endfunction

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
