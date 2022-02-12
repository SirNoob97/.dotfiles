#!/bin/sh

# Sutostart script for Qtile

cmd_exist() {
  command -v "$1" >/dev/null 2>&1
}

__kill() {
  kill -9 "$(pidof "$1")" >/dev/null 2>&1
}

__start() {
  sleep 1
  "$@" >/dev/null 2>&1 &
}

# Authentication dialog
#if [ -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
#    __kill polkit-gnome-authentication-agent-1
#    __start /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#fi

# Wallpaper manager
if cmd_exist feh ; then
  __kill feh
  __start feh --randomize --bg-fill --no-fehbg /home/martin/Pictures/Wallpaper &
fi

# Notification daemon
if cmd_exist dunst ; then
  __kill dunst
  __start dunst
fi

# Network manager
#if cmd_exist nm-applet ; then
    #__kill nm-applet
    #__start nm-applet
#fi

exit 0
