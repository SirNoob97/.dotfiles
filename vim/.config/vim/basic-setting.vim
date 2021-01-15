set nocompatible
set encoding=UTF-8
set mouse=a
set t_Co=256

filetype plugin indent on

syntax on

set hidden
set timeout timeoutlen=1500 ttimeoutlen=150

set updatetime=300

set splitbelow splitright

set history=1000
set nobackup
set noswapfile
set nowritebackup

set undofile
set undodir=~/.vim/undodir

set noshowmode
set number
set relativenumber

set hlsearch
set smartcase
set ignorecase
set incsearch

set omnifunc=syntaxcomplete#Complete
set suffixesadd=.java

set autoindent
set shiftwidth=2
set cindent
set smarttab
set tabstop=2 softtabstop=2
set expandtab
set nowrap

set showmatch
set showcmd

set backspace=indent,eol,start

set spelllang=en_gb

filetype indent plugin on

" This is to change the cursor according to the mode
let &t_SI.="\<Esc>[5 q"
let &t_SR.="\<Esc>[2 q"
let &t_EI.="\<Esc>[1 q"
