#!/bin/bash -e

pwd
ls -al
printenv

# WERCKER_STEP_ROOT="/wercker/steps/plasticine/librato-build-metrics/0.0.5"
# WERCKER_GIT_REPOSITORY=foo-bar
# WERCKER_GIT_BRANCH=master
# WERCKER_LIBRATO_BUILD_METRICS_USER=herp
# WERCKER_LIBRATO_BUILD_METRICS_TOKEN=derp
# WERCKER_MAIN_PIPELINE_STARTED=123456
# WERCKER_MAIN_PIPELINE_FINISHED=112233
# WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE=test
# WERCKER_RESULT=passed
# DEPLOY=false

echo $WERCKER_LIBRATO_BUILD_METRICS_USER
echo $WERCKER_LIBRATO_BUILD_METRICS_TOKEN

if [[ -n "$WERCKER_STEP_ROOT" && $WERCKER_STEP_ROOT != "/wercker/steps/wercker/script/0.0.0" ]]; then
  source "${WERCKER_STEP_ROOT}/support/wercker-functions.sh"
  source "${WERCKER_STEP_ROOT}/support/librato-functions.sh"
else
  source ./support/wercker-functions.sh
  source ./support/librato-functions.sh
fi

measure_build_time() {
  if ! is_deploy; then
    local value=$(build_time)
    local source=$(branch_name)

    add_gauge 'builds.duration' $value $source
  else
    echo '[INFO] Skipping, build is a deploy.'
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
  else
    echo '[INFO] Skipping, build is a deploy.'
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

echo 'measuring...'

measure_build_time
measure_build_state
publish

echo 'done!'
