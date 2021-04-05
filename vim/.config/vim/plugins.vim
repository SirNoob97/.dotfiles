call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'uiiaoo/java-syntax.vim'

  Plug 'puremourning/vimspector'

  Plug 'dense-analysis/ale'

  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'

  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'preservim/nerdtree'

  Plug 'gruvbox-community/gruvbox'
call plug#end()
