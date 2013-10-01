#!/bin/bash -e

is_deploy() {
  if [[ -n "$1" ]]; then
    return 0
  fi
  return 1
}

on_master_branch() {
  if [[ $WERCKER_GIT_BRANCH == "master" ]]; then
    return 0
  fi
  return 1
}

build_passed() {
  if [[ "$WERCKER_RESULT" = "passed" ]]; then
    return 0
  fi
  return 1
}

# function build_time {
#   return ($WERCKER_MAIN_PIPELINE_FINISHED - $WERCKER_MAIN_PIPELINE_STARTED)
# }
