#!/bin/bash -e

is_deploy() {
  # $1: $DEPLOY
  if [[ -n "$1" ]]; then
    return 0
  fi
  return 1
}

on_master_branch() {
  # $1: $WERCKER_GIT_BRANCH
  if [[ $1 == "master" ]]; then
    return 0
  fi
  return 1
}

build_passed() {
  # $1: $WERCKER_RESULT
  if [[ "$1" = "passed" ]]; then
    return 0
  fi
  return 1
}

function build_time {
  # $1: $WERCKER_MAIN_PIPELINE_FINISHED
  # $2: $WERCKER_MAIN_PIPELINE_STARTED
  return `expr $1 - $2`
}
