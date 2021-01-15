"vim-go plugin, commenting on this confirms that syntax highlighting files are the problem or the logic behind them
"autocmd BufRead,BufNewFile *.go setfiletype 'go'
"autocmd BufRead,BufNewFile go.sum set filetype=gosum
"autocmd! BufRead,BufNewFile *.mod,*.MOD
"autocmd BufRead,BufNewFile go.mod call s:gomod()

"fun! s:gomod()
  "for l:i in range(1, line('$'))
    "let l:l = getline(l:i)
    "if l:l ==# '' || l:l[:1] ==# '//'
      "continue
    "endif

    "if l:l =~# '^module .\+'
      "setfiletype gomod
    "endif

    "break
  "endfor
"endfun
