#!/bin/bash -e

source ./test/test_helper.sh
source ./support/librato-functions.sh

describe "librato_namespace"

it_should_print_the_default_namespace_if_one_has_not_been_set() {
  unset $WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE
  WERCKER_APPLICATION_NAME='scuba-ninja'
  result=$(set +e ; librato_namespace)
  test $result == 'wercker.scuba-ninja'
}

it_should_use_a_custom_namespace() {
  WERCKER_APPLICATION_NAME='boring-default'
  WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE='amazeballz'
  result=$(set +e ; librato_namespace)
  test $result == 'wercker.amazeballz'
}
