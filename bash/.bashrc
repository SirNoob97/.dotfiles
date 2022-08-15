#!/usr/bin/env bash
case $- in
  *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

[ -n "$force_color_prompt" ] && \
    $([ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null && color_prompt=yes || color_prompt=)

[ "$color_prompt" = yes ] && \
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;31m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' || \
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

source $HOME/.aliases
source $HOME/.config/bashconfig/completion.sh
source $HOME/.config/bashconfig/alias_completion.sh
source $HOME/.config/bashconfig/version_managers.sh
