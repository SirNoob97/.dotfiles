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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

command! -nargs=0 ORI   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nmap <silent> <leader>** :Fold<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> <leader>rn <Plug>(coc-rename)

xmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f :Format<CR>

nmap <silent> <leader>o :ORI<CR>
nmap <silent> <leader>gf <Plug>(coc-fix-current)

nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<CR>
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<CR>

nmap <silent><leader>a <Plug>(coc-codeaction)
vmap <silent><leader>a <Plug>(coc-codeaction-selected)
nmap <silent><leader>ca <Plug>(coc-codeaction-selected) <>

inoremap <silent><expr> <NUL> coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ?  coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nnoremap <silent><leader>CR :CocRestart<CR>
nnoremap <silent><leader>CD :CocDisable<CR>
nnoremap <silent><leader>CE :CocEnable<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

