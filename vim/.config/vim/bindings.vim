let mapleader=" "

" toggle spell checker
map <silent>` :setlocal spell!<CR>

" disable highlighting search result on Enter key
nnoremap <silent><silent> <CR> :nohlsearch<CR><CR>

" copy, paste
inoremap <silent><C-V> <Esc> "*p
vnoremap <silent><C-c> "+y
vnoremap <silent><C-d> "+d

" move lines
nnoremap ++ :m -2<CR>
nnoremap -- :m +1<CR>
vnoremap ++ :m '<-2<CR>v
vnoremap -- :m '>+1<CR>v

" move between panes
map <silent><C-h> <C-w>h
map <silent><C-j> <C-w>j
map <silent><C-k> <C-w>k
map <silent><C-l> <C-w>l

" buffers
nnoremap <silent><TAB> :bnext<CR>
nnoremap <silent><S-TAB> :bprevious<CR>
nnoremap <silent><leader>d :bdelete<CR>

" split screen
nnoremap <silent><leader>h :split<CR>
nnoremap <silent><leader>v :vsplit<CR>

" resize panes
nnoremap <silent><leader><up> :resize +5<CR>
nnoremap <silent><leader><down> :resize -5<CR>
nnoremap <silent><leader><right> :vertical resize -5<CR>
nnoremap <silent><leader><left> :vertical resize +5<CR>
