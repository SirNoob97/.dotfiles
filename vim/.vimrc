source ~/.config/vim/disable-ntrw.vim
source ~/.config/vim/basic-setting.vim
source ~/.config/vim/bindings.vim
source ~/.config/vim/plugins.vim

source ~/.config/vim/plugings/gruvbox.vim

source ~/.config/vim/theme.vim

source ~/.config/vim/plugings/airline.vim
source ~/.config/vim/plugings/nerdtree.vim
source ~/.config/vim/plugings/undotree.vim
source ~/.config/vim/plugings/nerdcommenter.vim

source ~/.config/vim/plugings/ale.vim
source ~/.config/vim/plugings/coc.vim

source ~/.config/vim/plugings/vim-go.vim

autocmd FileType go :call VimGo()
autocmd FileType java,json,yaml,html,javascript,css :call Coc()
