" VimSpector
let g:vimspector_enable_mappings = 'HUMAN'

nmap <F1> :CocCommand java.debug.vimspector.start<CR>
nmap <F2> :VimspectorReset<CR>

nmap <F5>	<Plug>VimspectorContinue
nmap <F3>	<Plug>VimspectorStop
nmap <F4>	<Plug>VimspectorRestart
nmap <F6>	<Plug>VimspectorPause
nmap <F9>	<Plug>VimspectorToggleBreakpoint
nmap <F8>	<Plug>VimspectorAddFunctionBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut
nmap <leader><F8> <Plug>VimspectorRunToCursor
nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint

nmap <Leader>b <Plug>VimspectorBalloonEval
xmap <Leader>b <Plug>VimspectorBalloonEval
