#!/bin/bash -e

# Returns true if the build is a deploy.
is_deploy() {
  if [[ -n "$DEPLOY" && $DEPLOY == "true" ]]; then
    return 0
  fi
  return 1
}

# Returns true if build branch is master.
on_master_branch() {
  if [[ $WERCKER_GIT_BRANCH == "master" ]]; then
    return 0
  fi
  return 1
}

# Returns the build status as a boolean.
build_passed() {
  if [[ $WERCKER_RESULT == "passed" ]]; then
    return 0
  fi
  return 1
}

# Returns the branch name of the current build, or non-zero if not set
branch_name() {
  if [[ $WERCKER_GIT_BRANCH ]]; then
    echo $WERCKER_GIT_BRANCH
    return 0
  fi
  return 1
}

# Returns the build time duration in seconds elapsed.
build_time() {
  decimal_regex='^[0-9]+$'

  if [[ -n $WERCKER_MAIN_PIPELINE_FINISHED && -n $WERCKER_MAIN_PIPELINE_STARTED ]]; then
    if [[ $WERCKER_MAIN_PIPELINE_FINISHED =~ $decimal_regex && $WERCKER_MAIN_PIPELINE_STARTED =~ $decimal_regex ]]; then
       echo $(($WERCKER_MAIN_PIPELINE_FINISHED - $WERCKER_MAIN_PIPELINE_STARTED))
       return 0
    fi
  fi
  return 1
}
