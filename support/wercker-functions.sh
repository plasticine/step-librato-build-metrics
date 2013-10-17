#!/bin/bash -e

# Returns true if the build is a deploy.
#
# $1: $DEPLOY
is_deploy() {
  if [[ -n "$1" ]]; then
    return 0
  fi
  return 1
}

# Returns true if build branch is master.
#
# $1: $WERCKER_GIT_BRANCH
on_master_branch() {
  if [[ $1 == "master" ]]; then
    return 0
  fi
  return 1
}

# Returns the branch name of the current build, or non-zero if not set
branch_name() {
  if [[ $WERCKER_GIT_BRANCH ]]; then
    return $WERCKER_GIT_BRANCH
  fi
  return 1
}

# Returns the build status as a boolean.
#
# $1: $WERCKER_RESULT
build_passed() {
  if [[ "$1" = "passed" ]]; then
    return 0
  fi
  return 1
}

# Returns the build time duration in seconds elapsed.
build_time() {
  decimal_regex='^[0-9]+$'

  if [[ -n $WERCKER_MAIN_PIPELINE_FINISHED && -n $WERCKER_MAIN_PIPELINE_STARTED ]]; then
    if [[ $WERCKER_MAIN_PIPELINE_FINISHED =~ $decimal_regex && $WERCKER_MAIN_PIPELINE_STARTED =~ $decimal_regex ]]; then
       return "`expr $WERCKER_MAIN_PIPELINE_FINISHED - $WERCKER_MAIN_PIPELINE_STARTED`"
    fi
  fi
  return 1
}
