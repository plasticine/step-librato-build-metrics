#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "build_time"

it_returns_the_difference_between_two_timestamps() {
  WERCKER_MAIN_PIPELINE_FINISHED=1380619271
  WERCKER_MAIN_PIPELINE_STARTED=1380619247
  result=$(set +e ; build_time ; echo $?)
  test "24" -eq $result
}

it_returns_falsy_when_not_passed_any_params() {
  WERCKER_MAIN_PIPELINE_FINISHED=
  WERCKER_MAIN_PIPELINE_STARTED=
  result=$(set +e ; build_time ; echo $?)
  test 1 -eq $result

  result=$(set +e ; build_time ; echo $?)
  test 1 -eq $result
}

it_returns_falsy_when_passed_stupid_things() {
  WERCKER_MAIN_PIPELINE_FINISHED=herp
  WERCKER_MAIN_PIPELINE_STARTED=derp
  result=$(set +e ; build_time ; echo $?)
  test 1 -eq $result
}
