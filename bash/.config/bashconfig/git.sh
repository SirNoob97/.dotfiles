#!/usr/bin/env bash

function _git-symbolic-ref {
 git symbolic-ref -q HEAD 2> /dev/null
}

# When on a branch, this is often the same as _git-commit-description,
# but this can be different when two branches are pointing to the
# same commit. _git-branch is used to explicitly choose the checked-out
# branch.
function _git-branch {
  if [[ "${SCM_GIT_GITSTATUS_RAN}" == "true" ]]; then
    test -n "${VCS_STATUS_LOCAL_BRANCH}" && echo "${VCS_STATUS_LOCAL_BRANCH}" || return 1
  else
    git symbolic-ref -q --short HEAD 2> /dev/null || return 1
  fi
}

function _git-tag {
  if [[ "${SCM_GIT_GITSTATUS_RAN}" == "true" ]]; then
    test -n "${VCS_STATUS_TAG}" && echo "${VCS_STATUS_TAG}"
  else
    git describe --tags --exact-match 2> /dev/null
  fi
}

function _git-commit-description {
  git describe --contains --all 2> /dev/null
}

function _git-short-sha {
  if [[ "${SCM_GIT_GITSTATUS_RAN}" == "true" ]]; then
    echo ${VCS_STATUS_COMMIT:0:7}
  else
    git rev-parse --short HEAD
  fi
}

# Try the checked-out branch first to avoid collision with branches pointing to the same ref.
function _git-friendly-ref {
  if [[ "${SCM_GIT_GITSTATUS_RAN}" == "true" ]]; then
    _git-branch || _git-tag || _git-short-sha # there is no tag based describe output in gitstatus
  else
    _git-branch || _git-tag || _git-commit-description || _git-short-sha
  fi
}

function _git-num-remotes {
  git remote | wc -l
}

function _git-upstream {
  local ref
  ref="$(_git-symbolic-ref)" || return 1
  git for-each-ref --format="%(upstream:short)" "${ref}"
}

function _git-upstream-remote {
  local upstream
  upstream="$(_git-upstream)" || return 1

  local branch
  branch="$(_git-upstream-branch)" || return 1
  echo "${upstream%"/${branch}"}"
}

function _git-upstream-branch {
  local ref
  ref="$(_git-symbolic-ref)" || return 1

  # git versions < 2.13.0 do not support "strip" for upstream format
  # regex replacement gives the wrong result for any remotes with slashes in the name,
  # so only use when the strip format fails.
  git for-each-ref --format="%(upstream:strip=3)" "${ref}" 2> /dev/null || git for-each-ref --format="%(upstream)" "${ref}" | sed -e "s/.*\/.*\/.*\///"
}

function _git-upstream-behind-ahead {
  git rev-list --left-right --count "$(_git-upstream)...HEAD" 2> /dev/null
}

function _git-status {
  local git_status_flags=
  [[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && git_status_flags='-uno' || true
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
