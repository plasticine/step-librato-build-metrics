#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "on_master_branch"

it_returns_truthy_if_the_current_branch_is_master() {
  WERCKER_GIT_BRANCH='master'
  result=$(set +e ; on_master_branch ; echo $?)
  test 0 -eq $result
}

it_returns_falsy_if_the_current_branch_is_not_master() {
  WERCKER_GIT_BRANCH='herp-derp-branchname'
  result=$(set +e ; on_master_branch ; echo $?)
  test 1 -eq $result
}
