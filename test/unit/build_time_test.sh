#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "build_time"

it_returns_the_difference_between_two_timestamps() {
  result=$(set +e ; build_time 1380619271 1380619247 ; echo $?)
  test "24" -eq $result
}

it_returns_falsy_when_not_passed_any_params() {
  result=$(set +e ; build_time ; echo $?)
  test 1 -eq $result

  result=$(set +e ; build_time 1380619271 ; echo $?)
  test 1 -eq $result
}

it_returns_falsy_when_passed_stupid_things() {
  result=$(set +e ; build_time herp derp ; echo $?)
  test 1 -eq $result
}
