source ~/.config/vim/disable-ntrw.vim
source ~/.config/vim/basic-setting.vim
source ~/.config/vim/bindings.vim
source ~/.config/vim/plugins.vim

source ~/.config/vim/theme.vim

source ~/.config/vim/plugings/gruvbox.vim

source ~/.config/vim/plugings/airline.vim
source ~/.config/vim/plugings/nerdtree.vim
source ~/.config/vim/plugings/undotree.vim
source ~/.config/vim/plugings/nerdcommenter.vim

autocmd FileType go :source ~/.config/vim/plugings/vim-go.vim | :source ~/.config/vim/plugings/ale.vim | :call VimGo()

autocmd FileType java,javascript,typescript,vim :source ~/.config/vim/plugings/coc.vim | :source ~/.config/vim/plugings/vimspector.vim | :call Coc()
