#!/usr/bin/env bash

SCM=

SCM_CHECK=${SCM_CHECK:=true}

SCM_THEME_PROMPT_DIRTY=' ✗'
SCM_THEME_PROMPT_CLEAN=' ✓'
SCM_THEME_PROMPT_PREFIX=' |'
SCM_THEME_PROMPT_SUFFIX='|'
SCM_THEME_BRANCH_PREFIX=''
SCM_THEME_TAG_PREFIX='tag:'
SCM_THEME_DETACHED_PREFIX='detached:'
SCM_THEME_BRANCH_TRACK_PREFIX=' → '
SCM_THEME_BRANCH_GONE_PREFIX=' ⇢ '
SCM_THEME_CHAR_PREFIX=''
SCM_THEME_CHAR_SUFFIX=''

SCM_GIT_SHOW_DETAILS=${SCM_GIT_SHOW_DETAILS:=true}
SCM_GIT_SHOW_REMOTE_INFO=${SCM_GIT_SHOW_REMOTE_INFO:=auto}
SCM_GIT_IGNORE_UNTRACKED=${SCM_GIT_IGNORE_UNTRACKED:=false}
SCM_GIT_SHOW_CURRENT_USER=${SCM_GIT_SHOW_CURRENT_USER:=false}
SCM_GIT_SHOW_MINIMAL_INFO=${SCM_GIT_SHOW_MINIMAL_INFO:=false}
SCM_GIT_SHOW_STASH_INFO=${SCM_GIT_SHOW_STASH_INFO:=true}
SCM_GIT_SHOW_COMMIT_COUNT=${SCM_GIT_SHOW_COMMIT_COUNT:=true}
SCM_GIT_USE_GITSTATUS=${SCM_GIT_USE_GITSTATUS:=false}
SCM_GIT_GITSTATUS_RAN=${SCM_GIT_GITSTATUS_RAN:=false}

SCM_GIT='git'
SCM_GIT_CHAR='±'
SCM_GIT_DETACHED_CHAR='⌿'
SCM_GIT_AHEAD_CHAR="↑"
SCM_GIT_BEHIND_CHAR="↓"
SCM_GIT_AHEAD_BEHIND_PREFIX_CHAR=" "
SCM_GIT_UNTRACKED_CHAR="?:"
SCM_GIT_UNSTAGED_CHAR="U:"
SCM_GIT_STAGED_CHAR="S:"
SCM_GIT_STASH_CHAR_PREFIX="{"
SCM_GIT_STASH_CHAR_SUFFIX="}"

GIT_EXE=$(which git 2> /dev/null || true)

function scm {
  if [[ "$SCM_CHECK" = false ]]; then SCM=$SCM_NONE
  elif [[ -f .git/HEAD ]] && [[ -x "$GIT_EXE" ]]; then SCM=$SCM_GIT
  elif [[ -x "$GIT_EXE" ]] && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then SCM=$SCM_GIT
  else SCM=$SCM_NONE
  fi
}

function scm_prompt_char {
  if [[ -z $SCM ]]; then scm; fi
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
}

function scm_prompt_vars {
  scm
  scm_prompt_char
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_vars && return
}

function scm_prompt_info {
  scm
  scm_prompt_char
  scm_prompt_info_common
}

function scm_prompt_char_info {
  scm_prompt_char
  echo -ne "${SCM_THEME_CHAR_PREFIX}${SCM_CHAR}${SCM_THEME_CHAR_SUFFIX}"
  scm_prompt_info_common
}

function scm_prompt_info_common {
  SCM_DIRTY=0
  SCM_STATE=''

  if [[ ${SCM} == ${SCM_GIT} ]]; then
    if [[ ${SCM_GIT_SHOW_MINIMAL_INFO} == true ]]; then
      # user requests minimal git status information
      git_prompt_minimal_info
    else
      # more detailed git status
      git_prompt_info
    fi
    return
  fi

}

function git_prompt_minimal_info {
  SCM_STATE=${SCM_THEME_PROMPT_CLEAN}

  SCM_BRANCH="${SCM_THEME_BRANCH_PREFIX}\$(_git-friendly-ref)"

  if [[ -n "$(_git-status | tail -n1)" ]]; then
    SCM_DIRTY=1
    SCM_STATE=${SCM_THEME_PROMPT_DIRTY}
  fi

  # Output the git prompt
  SCM_PREFIX=${SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${SCM_THEME_PROMPT_SUFFIX}
  echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}"
}

function git_prompt_vars {
    SCM_GIT_GITSTATUS_RAN=false

  if _git-branch &> /dev/null; then
    SCM_GIT_DETACHED="false"
    SCM_BRANCH="${SCM_THEME_BRANCH_PREFIX}\$(_git-friendly-ref)"
  else
    SCM_GIT_DETACHED="true"

    local detached_prefix
    if _git-tag &> /dev/null; then
      detached_prefix=${SCM_THEME_TAG_PREFIX}
    else
      detached_prefix=${SCM_THEME_DETACHED_PREFIX}
    fi
    SCM_BRANCH="${detached_prefix}\$(_git-friendly-ref)"
  fi

  if [[ "${SCM_GIT_SHOW_STASH_INFO}" = "true" ]]; then
    local stash_count
      stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
    [[ "${stash_count}" -gt 0 ]] && SCM_BRANCH+=" ${SCM_GIT_STASH_CHAR_PREFIX}${stash_count}${SCM_GIT_STASH_CHAR_SUFFIX}"
  fi

  SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  IFS=$'\t' read -r untracked_count unstaged_count staged_count <<< "$(_git-status-counts)"
    if [[ "${untracked_count}" -gt 0 || "${unstaged_count}" -gt 0 || "${staged_count}" -gt 0 ]]; then
      SCM_DIRTY=1
      if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
        [[ "${staged_count}" -gt 0 ]] && SCM_BRANCH+=" ${SCM_GIT_STAGED_CHAR}${staged_count}" && SCM_DIRTY=3
        [[ "${unstaged_count}" -gt 0 ]] && SCM_BRANCH+=" ${SCM_GIT_UNSTAGED_CHAR}${unstaged_count}" && SCM_DIRTY=2
        [[ "${untracked_count}" -gt 0 ]] && SCM_BRANCH+=" ${SCM_GIT_UNTRACKED_CHAR}${untracked_count}" && SCM_DIRTY=1
      fi
      SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
    fi

  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}

  SCM_CHANGE=$(_git-short-sha 2>/dev/null || echo "")
}

# backwards-compatibility
function git_prompt_info {
  git_prompt_vars
  echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}"
}


function scm_char {
  scm_prompt_char
  echo -e "${SCM_THEME_CHAR_PREFIX}${SCM_CHAR}${SCM_THEME_CHAR_SUFFIX}"
}

function prompt_char {
    scm_char
}

function __check_precmd_conflict() {
    local f
    for f in "${precmd_functions[@]}"; do
        if [[ "${f}" == "${1}" ]]; then
            return 0
        fi
    done
    return 1
}

function safe_append_prompt_command {
    local prompt_re

    if [ "${__bp_imported}" == "defined" ]; then
        # We are using bash-preexec
        if ! __check_precmd_conflict "${1}" ; then
            precmd_functions+=("${1}")
        fi
    else
        # Set OS dependent exact match regular expression
        if [[ ${OSTYPE} == darwin* ]]; then
          # macOS
          prompt_re="[[:<:]]${1}[[:>:]]"
        else
          # Linux, FreeBSD, etc.
          prompt_re="\<${1}\>"
        fi

        if [[ ${PROMPT_COMMAND} =~ ${prompt_re} ]]; then
          return
        elif [[ -z ${PROMPT_COMMAND} ]]; then
          PROMPT_COMMAND="${1}"
        else
          PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
        fi
    fi
}
