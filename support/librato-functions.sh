#!/bin/bash -e

export LIBRATO_ENDPOINT="https://metrics-api.librato.com/v1/metrics"
_request_data_buffer=''

_reset_counter_param_iterator() {
  _counter_param_iterator=0
}

_reset_gauge_param_iterator() {
  _gauge_param_iterator=0
}

_add_data() {
  _request_data_buffer="${_request_data_buffer}-d ${1} "
}

_make_request() {
  if [[ -n $_request_data_buffer ]]; then
    curl -s \
      -u ${LIBRATO_USER}:${LIBRATO_TOKEN} \
      ${_request_data_buffer} \
      -X POST \
      "${LIBRATO_ENDPOINT}"
  else
    return 1
  fi
}

# Publishes metrics to librato and resets measurement data counters
publish() {
  _make_request
  _reset_counter_param_iterator
  _reset_gauge_param_iterator
}

# Adds a counter measurement
#
# $1: counter name
# $2: value
# $3: source name
#
# TODO: spec
add_counter() {
  if [[ $_counter_param_iterator ]]; then
    _counter_param_iterator=$((_counter_param_iterator + 1))
  else
    _reset_counter_param_iterator
  fi

  _add_data "counters[${_counter_param_iterator}][name]=${1}"
  _add_data "counters[${_counter_param_iterator}][value]=${2}"

  [ $3 ] && _add_data "counters[${_counter_param_iterator}][source]=${3}"
}

# Adds a gauge measurement
#
# $1: gauge name
# $2: value
# $3: source name
#
# TODO: spec
add_gauge() {
  if [[ $_gauge_param_iterator ]]; then
    _gauge_param_iterator=$((_gauge_param_iterator + 1))
  else
    _reset_gauge_param_iterator
  fi

  _add_data "gauges[${_gauge_param_iterator}][name]=${1}"
  _add_data "gauges[${_gauge_param_iterator}][value]=${2}"

  [ $3 ] && _add_data "gauges[${_gauge_param_iterator}][source]=${3}"
}
