call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'uiiaoo/java-syntax.vim'

  Plug 'dense-analysis/ale'

  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'

  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'preservim/nerdtree'
  Plug 'scrooloose/nerdcommenter'

  Plug 'mbbill/undotree'

  Plug 'morhetz/gruvbox'

call plug#end()
