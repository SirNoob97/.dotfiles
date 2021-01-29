call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  "Plug 'natebosch/vim-lsc/'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'uiiaoo/java-syntax.vim'

  Plug 'dense-analysis/ale'

  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'

  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'preservim/nerdtree'
  Plug 'scrooloose/nerdcommenter'

  Plug 'mbbill/undotree'

  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'morhetz/gruvbox'

call plug#end()

"let g:lsc_server_commands = {
"\  "go": {
"\    "command": "gopls serve",
"\    "log_level": -1,
"\    "suppress_stderr": v:true,
"\  },
"\}
