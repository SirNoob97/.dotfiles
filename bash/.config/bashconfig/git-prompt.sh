#!/usr/bin/env bash

GIT_CHECK=${GIT_CHECK:=true}
IS_GIT_PROJECT=${IS_GIT_PROJECT:=false}
WHICH_GIT=$(which git 2> /dev/null || true)

GIT_SHOW_DETAILS=${GIT_SHOW_DETAILS:=true}
GIT_IGNORE_UNTRACKED=${GIT_IGNORE_UNTRACKED:=false}
GIT_SHOW_STASH_INFO=${GIT_SHOW_STASH_INFO:=true}

GIT_DETACHED_CHAR='⌿'
GIT_UNTRACKED_CHAR="?:"
GIT_UNSTAGED_CHAR="U:"
GIT_STAGED_CHAR="S:"
GIT_STASH_CHAR_PREFIX="{"
GIT_STASH_CHAR_SUFFIX="}"

GIT_PROMPT_PREFIX=" ${bold_blue}git:("
GIT_PROMPT_CLEAN=" ${bold_green}✓"
GIT_PROMPT_DIRTY=" ${bold_yellow}✗"
GIT_PROMPT_SUFFIX="${bold_blue})"

function _git_prompt_info {
  _git-check
  _git_prompt_info_common
}

function _git_prompt_info_common {
  GIT_DIRTY=0
  GIT_STATE=''

  if ${IS_GIT_PROJECT}; then
    _git_prompt_vars
    echo -e "${GIT_PREFIX}${bold_red}${GIT_BRANCH}${GIT_STATE}${reset_color}${GIT_SUFFIX}"
    return
  fi
}

function _git_prompt_vars {
  if _git-branch &> /dev/null; then
    GIT_DETACHED="false"
    GIT_BRANCH="$(_git-branch)"
  else
    GIT_DETACHED="true"

    local detached_prefix
    detached_prefix=${GIT_DETACHED_CHAR}
    GIT_BRANCH="${detached_prefix}\$(_git-branch)"
  fi

  if [[ "${GIT_SHOW_STASH_INFO}" = "true" ]]; then
    local stash_count
    stash_count=$(_git-stash-count)
    [[ "${stash_count}" -gt 0 ]] && GIT_BRANCH+=" ${GIT_STASH_CHAR_PREFIX}${stash_count}${GIT_STASH_CHAR_SUFFIX}"
  fi

  GIT_STATE=${GIT_PROMPT_CLEAN}
  IFS=$'\t' read -r untracked_count unstaged_count staged_count <<< "$(_git-status-counts)"
  if [[ "${untracked_count}" -gt 0 || "${unstaged_count}" -gt 0 || "${staged_count}" -gt 0 ]]; then
    GIT_DIRTY=1
    if [[ "${GIT_SHOW_DETAILS}" = "true" ]]; then
      [[ "${staged_count}" -gt 0 ]] && GIT_BRANCH+=" ${GIT_STAGED_CHAR}${staged_count}" && GIT_DIRTY=3
      [[ "${unstaged_count}" -gt 0 ]] && GIT_BRANCH+=" ${GIT_UNSTAGED_CHAR}${unstaged_count}" && GIT_DIRTY=2
      [[ "${untracked_count}" -gt 0 ]] && GIT_BRANCH+=" ${GIT_UNTRACKED_CHAR}${untracked_count}" && GIT_DIRTY=1
    fi
    GIT_STATE=${GIT_PROMPT_DIRTY}
  fi

  GIT_PREFIX=${GIT_PROMPT_PREFIX}
  GIT_SUFFIX=${GIT_PROMPT_SUFFIX}
}
