let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \"go": ['golint', 'go vet'],
      \}

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
