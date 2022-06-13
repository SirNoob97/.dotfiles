let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 0
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

nnoremap <silent> <leader>// <Plug>NERDCommenterToggle<CR>
vnoremap <silent> <leader>// <Plug>NERDCommenterToggle<CR>
vnoremap <silent> <leader>cb <Plug>NERDCommenterSexy<CR>
