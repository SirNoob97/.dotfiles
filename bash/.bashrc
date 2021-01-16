#!/usr/bin/env bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

export BASH_IT="/home/martin/.bash_it"
export BASH_IT_THEME='robbyrussell'

export GIT_HOSTING='git@git.domain.com'
unset MAILCHECK
export IRC_CLIENT='irssi'
export TODO="t"
export SCM_CHECK=true


EDITOR=vim
HISTCONTROL=ignoreboth

HISTSIZE=1000
HISTFILESIZE=2000

source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
source $HOME/.env
source $HOME/.aliases

alias bashconfig="sudo vim ~/.bashrc"
source "$BASH_IT"/bash_it.sh

complete -C /home/martin/bin/gocomplete go
