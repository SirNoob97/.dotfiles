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

  Plug 'morhetz/gruvbox'

call plug#end()

" Gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_hls_cursor = 'fg0'
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox

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

let g:coc_global_extensions = [ 'coc-marketplace',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-vimlsp' ]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col -1 ] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

command! -nargs=0 ORI   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nmap <silent> <leader>** :Fold<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> <leader>rn <Plug>(coc-rename)

xmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f :Format<CR>

nmap <silent> <leader>o :ORI<CR>
nmap <silent> <leader>gf <Plug>(coc-fix-current)

nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<CR>
nmap <silent> <leader>nd <Plug>(coc-diagnostic-next)
nmap <silent> <leader>pd <Plug>(coc-diagnostic-prev)

nnoremap <silent> <leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<CR>

nmap <silent><leader>a <Plug>(coc-codeaction)
vmap <silent><leader>a <Plug>(coc-codeaction-selected)
nmap <silent><leader>ca <Plug>(coc-codeaction-selected) <>

inoremap <silent><expr> <NUL> coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ?  coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nnoremap <silent><leader>CR :CocRestart<CR>
nnoremap <silent><leader>CD :CocDisable<CR>
nnoremap <silent><leader>CE :CocEnable<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" Mark in red the spaces at the end of the line
if &t_Co > 2
  highlight ExtraWhitespace ctermbg = 1
  match ExtraWhitespace /\s\+$/
else
  set listchars=trail:~
  set list
endif
