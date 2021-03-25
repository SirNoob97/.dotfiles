#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

source $HOME/.config/bashconfig/colors.sh
source $HOME/.config/bashconfig/git.sh
source $HOME/.config/bashconfig/git-prompt.sh
source $HOME/.config/bashconfig/theme.sh

EDITOR=vim
HISTCONTROL=ignoreboth

HISTSIZE=1000
HISTFILESIZE=2000

source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
source $HOME/.env
source $HOME/.aliases
source $HOME/.config/bashconfig/completion.sh
source $HOME/.config/bashconfig/alias-compleion.sh
source $HOME/scripts/maven.sh
source $HOME/scripts/docker.sh

alias bashconfig="sudo vim ~/.bashrc"

source $HOME/.fzf.bash

complete -C /home/martin/.local/bin/gocomplete go
eval "$(gh completion -s bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/martin/.sdkman"
[[ -s "/home/martin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/martin/.sdkman/bin/sdkman-init.sh"
