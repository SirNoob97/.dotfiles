#!/usr/bin/env bash

function prompt_command() {
  PS1="${bold_green}➜  ${bold_cyan}\W${reset_color}$(_git_prompt_info)${normal} "
}

PROMPT_COMMAND=prompt_command
