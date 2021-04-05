source ~/.config/vim/disable-ntrw.vim
source ~/.config/vim/basic-setting.vim
source ~/.config/vim/bindings.vim
source ~/.config/vim/plugins.vim

source ~/.config/vim/theme.vim

source ~/.config/vim/plugins/gruvbox.vim

source ~/.config/vim/plugins/airline.vim
source ~/.config/vim/plugins/nerdtree.vim
source ~/.config/vim/plugins/undotree.vim
source ~/.config/vim/plugins/nerdcommenter.vim

autocmd FileType go :source ~/.config/vim/plugins/vim-go.vim | :source ~/.config/vim/plugins/ale.vim | :call VimGo()

autocmd FileType java,javascript,typescript,vim :source ~/.config/vim/plugins/coc.vim | :source ~/.config/vim/plugins/vimspector.vim | :call Coc()
