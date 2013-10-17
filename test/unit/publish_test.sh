#!/bin/bash -e

source ./test/test_helper.sh
source ./support/librato-functions.sh

describe "publish"

it_should_reset_the_counter_param_iterator() {
  stub _make_request
  _counter_param_iterator=99
  publish

  test $_counter_param_iterator -eq 0
  restore _make_request
}

it_should_reset_the_gauge_param_iterator() {
  stub _make_request
  _gauge_param_iterator=99
  publish

  test $_gauge_param_iterator -eq 0
  restore _make_request
}
