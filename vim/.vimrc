" Disable Ntrw
let g:loaded_netrw = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwPlugin = 1

" Basics
set nocompatible
set encoding=UTF-8
set mouse=a
set t_Co=256

filetype plugin indent on
syntax on

set spelllang=en_gb
set backspace=indent,eol,start
set scrolloff=5

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
set completeopt=menuone,noinsert
set shortmess+=c
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

set fillchars+=vert:\┊
hi VertSplit term=none cterm=none gui=none
hi MatchParen ctermbg=DarkGray ctermfg=white
hi ExtraWhitSpace ctermbg=red
match ExtraWhitSpace /\s\+$/

" This is to change the cursor according to the mode
let &t_SI.="\<Esc>[6 q"
let &t_SR.="\<Esc>[2 q"
let &t_EI.="\<Esc>[2 q"

" Bindings
let mapleader=" "

map <silent>` :setlocal spell!<CR>

nnoremap <silent><silent> <CR> :nohlsearch<CR><CR>

inoremap <silent><C-V> <Esc> "*p
vnoremap <silent><C-c> "+y
vnoremap <silent><C-d> "+d

nnoremap ++ :m -2<CR>
nnoremap -- :m +1<CR>
vnoremap ++ :m '<-2<CR>v
vnoremap -- :m '>+1<CR>v

map <silent><C-h> <C-w>h
map <silent><C-j> <C-w>j
map <silent><C-k> <C-w>k
map <silent><C-l> <C-w>l

nnoremap <silent><TAB> :bnext<CR>
nnoremap <silent><S-TAB> :bprevious<CR>
nnoremap <silent><leader>d :bdelete<CR>

nnoremap <silent><leader>h :split<CR>
nnoremap <silent><leader>v :vsplit<CR>

nnoremap <silent><leader><up> :resize +5<CR>
nnoremap <silent><leader><down> :resize -5<CR>
nnoremap <silent><leader><right> :vertical resize -5<CR>
nnoremap <silent><leader><left> :vertical resize +5<CR>

" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'on': [] }
  Plug 'dense-analysis/ale', {'on': []}
  Plug 'ctrlpvim/ctrlp.vim', {'on': []}

  Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}
  Plug 'uiiaoo/java-syntax.vim', {'on': []}
  Plug 'puremourning/vimspector', {'on': []}

  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'

  Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

  Plug 'gruvbox-community/gruvbox'
call plug#end()

" Gruvbox
colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_light = 'medium'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" NerdTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['node_modules$']

augroup go_environment
  autocmd FileType go call plug#load('vim-go')
      \| :source ~/.config/vim/plugins/vim-go.vim

  autocmd FileType go call plug#load('ale')
      \| :source ~/.config/vim/plugins/ale.vim

  autocmd FileType go call plug#load('ctrlp.vim')
  autocmd FileType go :echo 'Press Space + rg to load the Go autocmd' | nmap <silent><leader>rg :edit<cr>
augroup END

augroup coc_environment
  autocmd FileType java call plug#load('vimspector') | :source ~/.config/vim/plugins/vimspector.vim
  autocmd FileType java call plug#load('java-syntax.vim')

  autocmd FileType c,java,javascript,typescript,html,vim,php,python,sql,json,yml,yaml call plug#load('coc.nvim')
      \| :source ~/.config/vim/plugins/coc.vim

  autocmd FileType c,java,javascript,typescript,html,vim,php,python,sql,json,yml,yaml 
        \ :echo 'Press Space + rc to load the Coc autocmd'
        \ | nmap <silent><leader>rc :edit<cr>
augroup END
