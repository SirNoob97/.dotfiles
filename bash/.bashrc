#!/usr/bin/env bash
case $- in
  *i*) ;;
    *) return;;
esac

#source $HOME/.config/bashconfig/colors.sh
#source $HOME/.config/bashconfig/git.sh
#source $HOME/.config/bashconfig/git-prompt.sh
#source $HOME/.config/bashconfig/theme.sh

EDITOR=vim
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[36;01m\]\u\[\033[33;01m\]@\[\033[32;01m\]\h\[\033[00m\]:\[\033[34;01m\]\w\[\033[0m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


source $HOME/.env
source $HOME/.aliases
source $HOME/.config/bashconfig/completion.sh
source $HOME/.config/bashconfig/alias-completion.sh
source $HOME/scripts/maven.sh
source $HOME/scripts/docker.sh

alias sbrc="source ~/.bashrc"
alias vbrc="vim ~/.bashrc"

source $HOME/.fzf.bash

complete -C /home/martin/.local/bin/gocomplete go
eval "$(gh completion -s bash)"
