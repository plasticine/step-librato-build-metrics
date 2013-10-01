#!/bin/bash -e

. ./test/test_helper.sh
. ./support/wercker-functions.sh

describe "is_deploy"

it_returns_truthy_if_the_current_build_is_a_deploy() {
  result=$(set +e ; is_deploy "true" ; echo $?)
  test 0 -eq $result
}

it_returns_falsy_if_the_current_build_is_not_a_deploy() {
  result=$(set +e ; is_deploy ; echo $?)
  test 1 -eq $result
}
