let g:vimspector_enable_mappings = 'HUMAN'

nmap <F1> :CocCommand java.debug.vimspector.start<CR>

nmap <Leader>b <Plug>VimspectorBalloonEval
xmap <Leader>b <Plug>VimspectorBalloonEval
