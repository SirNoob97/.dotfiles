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

set background=dark

set backspace=indent,eol,start

filetype indent plugin on

let mapleader=" "

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
Plug 'puremourning/vimspector', {'for': ['java']}

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdcommenter'

Plug 'mbbill/undotree'

Plug 'kien/ctrlp.vim'

Plug 'morhetz/gruvbox'

call plug#end()

" Gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_hls_cursor = 'fg0'
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Netrw
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_banner = 0

function! OpenToRight()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'belowright vnew' g:path
  :normal <C-w>l
endfunction

function! OpenBelow()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'belowright new' g:path
  :normal <C-w>l
endfunction

function! OpenTab()
  :normal v
  let g:path=expand('%:p')
  execute 'q!'
  execute 'tabedit' g:path
  :normal <C-w>l
endfunction

function! NetrwMappings()
  noremap <buffer> <C-l> <C-w>l
  noremap <silent> <C-f> :call ToggleNetrw()<CR>
  noremap <buffer> V :call OpenToRight()<cr>
  noremap <buffer> H :call OpenBelow()<cr>
  noremap <buffer> T :call OpenTab()<cr>
endfunction

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMappings()
augroup END

function! ToggleNetrw()
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i
      endif
      let i-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Vexplore
  endif
endfunction

 "Check before opening buffer on any file
function! NetrwOnBufferOpen()
  if exists('b:noNetrw')
    return
  endif
  call ToggleNetrw()
endfunction

augroup ProjectDrawer
autocmd!
autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END

let g:NetrwIsOpen=0

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

nmap <silent> <leader>a :<C-u>CocList actions<CR>

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

" Vimspector/Debug
let g:vimspector_enable_mappings = 'HUMAN'
nmap <F1> :CocCommand java.debug.vimspector.start<CR>
nmap <F2> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F4> <Plug>VimspectorRestart
nmap <F5> <Plug>VimspectorPause
nmap <F6> <Plug>VimspectorStepOver
nmap <F7> <Plug>VimspectorStepInto
nmap <F8> <Plug>VimspectorStepOut
nmap . <Plug>VimspectorToggleBreakpoint
nmap <leader>. <Plug>VimspectorToggleConditionalBreakpoint
nmap , <Plug>VimspectorAddFunctionBreakpoint

" Mark in red the spaces at the end of the line
if &t_Co > 2
  highlight ExtraWhitespace ctermbg = 1
  match ExtraWhitespace /\s\+$/
else
  set listchars=trail:~
  set list
endif
