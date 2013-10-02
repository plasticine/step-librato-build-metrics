#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "build_passed"

it_returns_truthy_if_the_build_passed() {
  result=$(set +e ; build_passed "passed" ; echo $?)
  test 0 -eq $result
}

it_returns_falsy_if_the_build_failed() {
  result=$(set +e ; build_passed "failed" ; echo $?)
  test 1 -eq $result

  result=$(set +e ; build_passed ; echo $?)
  test 1 -eq $result
}
