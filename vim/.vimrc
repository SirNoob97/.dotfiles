" Disable Ntrw
let g:loaded_netrw = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwPlugin = 1



set nocompatible
set encoding=UTF-8
set mouse=a
set t_Co=256
set background=dark

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

let mapleader=" "

" toggle spell checker
map <F5> :setlocal spell!<CR>

" disable highlighting search result on Enter key
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" copy, paste
inoremap <C-v> <Esc> "+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" tab or untab
nmap <Tab> :>><CR>
nmap <S-Tab> :<< <CR>
vmap <Tab> :>><CR>v
vmap <S-Tab> :<< <CR>v

" move lines
nnoremap ++ :m -2<CR>
nnoremap -- :m +1<CR>
vnoremap ++ :m '<-2<CR>v
vnoremap -- :m '>+1<CR>v

" move between panes
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" buffers
nmap <leader>n :bnext<CR>
nmap <leader>p :bprev<CR>
nmap <leader>d :bdelete<CR>

" split screen
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>

" resize panes
nnoremap <leader><up> :resize +5<CR>
nnoremap <leader><down> :resize -5<CR>
nnoremap <leader><right> :vertical resize -5<CR>
nnoremap <leader><left> :vertical resize +5<CR>

" This is to change the cursor according to the mode
let &t_SI.="\<Esc>[5 q"
let &t_SR.="\<Esc>[2 q"
let &t_EI.="\<Esc>[1 q"

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'uiiaoo/java-syntax.vim'

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'mbbill/undotree'

Plug 'kien/ctrlp.vim'

Plug 'morhetz/gruvbox'

call plug#end()

" Gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_hls_cursor = 'fg0'
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" NerdTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['node_modules$']

"UndoTree
let g:undotree_WindowLayout = 3
nnoremap <leader>u :UndotreeToggle<CR>

" Nerd Commenter
vmap \\ <plug>NERDCommenterToggle
nmap \\ <plug>NERDCommenterToggle

" COC
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col -1 ] =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rf <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
"nmap <leader>f ggVG<Plug>(coc-format-selected)

nmap <silent> <leader>a :<C-u>CocAction<CR>

nmap <leader>gf <Plug>(coc-fix-current)

nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<CR>

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

vmap <leader>ca  <Plug>(coc-codeaction-selected)
noremap <leader>cd  <Plug>(coc-codeaction-selected)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Mark in red the spaces at the end of the line
if &t_Co > 2
  highlight ExtraWhitespace ctermbg = 1
  match ExtraWhitespace /\s\+$/
else
  set listchars=trail:~
  set list
endif
