#!/usr/bin/env bash

function _git-check {
  if [[ ! $GIT_CHECK ]]; then IS_GIT_PROJECT=false
  elif [[ -f .git/HEAD ]] && [[ -x "$WHICH_GIT" ]]; then IS_GIT_PROJECT=true
  elif [[ -x "$WHICH_GIT" ]] && [[ -n "$(_git-workdir-check)" ]]; then IS_GIT_PROJECT=true
  else IS_GIT_PROJECT=false
  fi
}

function _git-workdir-check {
  git rev-parse --is-inside-work-tree 2> /dev/null || return 1
}

function _git-branch {
  git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}

function _git-status {
  local git_status_flags=
  [[ "${GIT_IGNORE_UNTRACKED}" = "true" ]] && git_status_flags='-uno' || true
  git status --porcelain ${git_status_flags} 2> /dev/null
}

function _git-status-counts {
  _git-status | awk '
  BEGIN {
    untracked=0;
    unstaged=0;
    staged=0;
  }
  {
    if ($0 ~ /^\?\? .+/) {
      untracked += 1
    } else {
      if ($0 ~ /^.[^ ] .+/) {
        unstaged += 1
      }
      if ($0 ~ /^[^ ]. .+/) {
        staged += 1
      }
    }
  }
  END {
    print untracked "\t" unstaged "\t" staged
  }'
}

function _git-stash-count {
  git stash list 2> /dev/null | wc -l
}
