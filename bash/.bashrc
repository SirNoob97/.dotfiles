#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

source $HOME/.config/bashconfig/colors.bash
source $HOME/.config/bashconfig/git.bash
source $HOME/.config/bashconfig/base.bash
source $HOME/.config/bashconfig/theme.bash

EDITOR=vim
HISTCONTROL=ignoreboth

HISTSIZE=1000
HISTFILESIZE=2000

source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
source $HOME/.env
source $HOME/.aliases
source $HOME/.config/bashconfig/completion.bash
source $HOME/.config/bashconfig/alias-compleion.bash
source $HOME/scripts/docker.bash

alias bashconfig="sudo vim ~/.bashrc"

source $HOME/.fzf.bash

complete -C /home/martin/.local/bin/gocomplete go
eval "$(gh completion -s bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/martin/.sdkman"
[[ -s "/home/martin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/martin/.sdkman/bin/sdkman-init.sh"
