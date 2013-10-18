#!/bin/bash -e

source ./support/wercker-functions.sh
source ./support/librato-functions.sh

# printenv
# WERCKER_GIT_REPOSITORY=foo-bar
# WERCKER_GIT_BRANCH=master
# WERCKER_LIBRATO_BUILD_METRICS_USER=herp
# WERCKER_LIBRATO_BUILD_METRICS_TOKEN=derp
# WERCKER_MAIN_PIPELINE_STARTED=123456
# WERCKER_MAIN_PIPELINE_FINISHED=112233
# WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE=test
# WERCKER_RESULT=passed
# DEPLOY=false

measure_build_time() {
  if ! is_deploy; then
    local value=$(build_time)
    local source=$(branch_name)

    add_gauge 'builds.duration' $value $source
  fi
}

measure_build_state() {
  if ! is_deploy; then
    local value=1
    local source=$(branch_name)

    if build_passed; then
      add_gauge 'builds.passed' $value $source
    else
      add_gauge 'builds.failed' $value $source
    fi
  fi
}

if [ ! -n "$WERCKER_LIBRATO_BUILD_METRICS_USER" ]; then
  echo '[ERROR] Please ensure that $WERCKER_LIBRATO_BUILD_METRICS_USER is set.'
  exit 1
fi

if [ ! -n "$WERCKER_LIBRATO_BUILD_METRICS_TOKEN" ]; then
  echo '[ERROR] Please ensure that $WERCKER_LIBRATO_BUILD_METRICS_TOKEN is set.'
  exit 1
fi

measure_build_time
measure_build_state
publish
