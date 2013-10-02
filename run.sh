#!/bin/sh +xe

. "./support/wercker-functions.sh"

# function publish_metric {
#   curl \
#     -u "$LIBRATO_USER":"$LIBRATO_TOKEN" \
#     -d "display_name='$1'&attributes[$2]=$3" \
#     -X PUT \
#     'https://metrics-api.librato.com/v1/metrics/test'
# }

if [[ on_master_branch && build_passed ]];
then
  publish_metric "CI Build Time", 'build_time', build_time
else
  info "Skipping..."
fi
