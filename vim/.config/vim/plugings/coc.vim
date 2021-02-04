" COC

let g:coc_global_extensions = [ 'coc-marketplace',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-vimlsp' ]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col -1 ] =~# '\s'
endfunction

"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

command! -nargs=0 ORI   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

func! Coc()
  nmap <silent> <leader>** :Fold<CR>
  
  nmap <buffer> <silent> gd <Plug>(coc-definition)
  nmap <buffer> <silent> gy <Plug>(coc-type-definition)
  nmap <buffer> <silent> gi <Plug>(coc-implementation)
  nmap <buffer> <silent> gr <Plug>(coc-references)
  
  nmap <buffer> <silent> <leader>rf <Plug>(coc-refactor)
  nmap <buffer> <silent> <leader>rn <Plug>(coc-rename)
  
  xmap <buffer> <silent> <leader>f <Plug>(coc-format-selected)
  nmap <buffer> <silent> <leader>f :Format<CR>
  
  nmap <buffer> <silent> <leader>o :ORI<CR>
  nmap <buffer> <silent> <leader>gf <Plug>(coc-fix-current)
  
  nnoremap <buffer> <silent> <leader>cd :<C-u>CocList diagnostics<CR>
  nmap <buffer> <silent> <leader>n <Plug>(coc-diagnostic-next)
  nmap <buffer> <silent> <leader>p <Plug>(coc-diagnostic-prev)
  
  nnoremap <buffer> <silent> <leader>co :<C-u>CocList outline<CR>
  nnoremap <buffer> <silent> <leader>cs :<C-u>CocList -I symbols<CR>
  
  nmap <buffer> <silent><leader>a <Plug>(coc-codeaction)
  vmap <buffer> <silent><leader>a <Plug>(coc-codeaction-selected)
  nmap <buffer> <silent><leader>ca <Plug>(coc-codeaction-selected) <>
  
  inoremap <buffer> <silent><expr> <NUL> coc#refresh()
  
  nnoremap <buffer> <silent> K :call <SID>show_documentation()<CR>
  
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  
  nnoremap <buffer> <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <buffer> <nowait><expr> <C-b> coc#float#has_scroll() ?  coc#float#scroll(0) : "\<C-b>"
  inoremap <buffer> <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <buffer> <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  
  nnoremap <buffer> <silent><leader>CR :CocRestart<CR>
  nnoremap <buffer> <silent><leader>CD :CocDisable<CR>
  nnoremap <buffer> <silent><leader>CE :CocEnable<CR>
endfun

autocmd CursorHold * silent call CocActionAsync('highlight')
