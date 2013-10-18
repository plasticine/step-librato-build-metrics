#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "build_passed"

it_returns_truthy_if_the_build_passed() {
  WERCKER_RESULT='passed'
  result=$(set +e ; build_passed ; echo $?)
  test 0 -eq $result
}

it_returns_falsy_if_the_build_failed() {
  WERCKER_RESULT='failed'
  result=$(set +e ; build_passed ; echo $?)
  test 1 -eq $result

  unset WERCKER_RESULT
  result=$(set +e ; build_passed ; echo $?)
  test 1 -eq $result
}
