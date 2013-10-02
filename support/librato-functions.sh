#!/bin/bash -e

function publish_metric {
  curl \
    -u "$LIBRATO_USER":"$LIBRATO_TOKEN" \
    -d "display_name='$1'&attributes[$2]=$3" \
    -X PUT \
    'https://metrics-api.librato.com/v1/metrics/test'
}
