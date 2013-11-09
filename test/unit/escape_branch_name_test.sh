#!/bin/bash -e

source ./test/test_helper.sh
source ./support/wercker-functions.sh

describe "escape_branch_name"

it_escapes_slashes() {
  result=$(set +e ; escape_branch_name "feature/foo-bar" ; )
  test $result == "feature_foo-bar"
}

it_escapes_dots() {
  result=$(set +e ; escape_branch_name "feature/foo.bar" ; )
  test $result == "feature_foo_bar"
}
