#!/usr/bin/env bash

# Loads the system's Bash completion modules.
# If Homebrew is installed (OS X), it's Bash completion modules are loaded.
if [[ -r /etc/bash_completion ]] ; then
  # shellcheck disable=SC1091
  source /etc/bash_completion

# Some distribution makes use of a profile.d script to import completion.
elif [[ -r /etc/profile.d/bash_completion.sh ]] ; then
  # shellcheck disable=SC1091
  source /etc/profile.d/bash_completion.sh

fi
