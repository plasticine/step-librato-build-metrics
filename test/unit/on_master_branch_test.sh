#!/bin/bash -e

. ./test/test_helper.sh
. ./support/wercker-functions.sh

describe "on_master_branch"

it_returns_truthy_if_the_current_branch_is_master() {
  result=$(set +e ; on_master_branch "master" ; echo $?)
  test 0 -eq $result
}

it_returns_falsy_if_the_current_branch_is_not_master() {
  result=$(set +e ; on_master_branch "some-other-branchname" ; echo $?)
  test 1 -eq $result
}
