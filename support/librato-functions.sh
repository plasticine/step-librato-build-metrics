#!/bin/bash -e

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
  if [[ -n "$_request_data_buffer" ]]; then
    curl -s \
      -u ${WERCKER_LIBRATO_BUILD_METRICS_USER}:${WERCKER_LIBRATO_BUILD_METRICS_TOKEN} \
      ${_request_data_buffer} \
      -X POST \
      "https://metrics-api.librato.com/v1/metrics"
  else
    return 1
  fi
}

# Prints out a namespace prefix for metrics, if the user has set one then
# use that, otherwise use the git repo name instead
librato_namespace() {
  if [[ -n "$WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE" ]]; then
    echo "wercker.${WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE}"
    return 0
  else
    echo "wercker.${WERCKER_APPLICATION_NAME}"
    return 0
  fi
  echo '[ERROR] Either $WERCKER_APPLICATION_NAME or $WERCKER_LIBRATO_BUILD_METRICS_NAMESPACE must be set.'
  exit 1
}

# Publishes metrics to librato and resets measurement data counters
publish() {
  echo "${_request_data_buffer}"
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

  local namespace=$(librato_namespace)

  _add_data "counters[${_counter_param_iterator}][name]=${namespace}.${1}"
  _add_data "counters[${_counter_param_iterator}][value]=${2}"

  [ -n "$3" ] && _add_data "counters[${_counter_param_iterator}][source]=${3}"
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

  local namespace=$(librato_namespace)

  _add_data "gauges[${_gauge_param_iterator}][name]=${namespace}.${1}"
  _add_data "gauges[${_gauge_param_iterator}][value]=${2}"

  [ -n "$3" ] && _add_data "gauges[${_gauge_param_iterator}][source]=${3}"
}
