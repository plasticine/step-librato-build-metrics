#!/bin/sh +xe

# function on_master_branch {
#   if [[ $WERCKER_GIT_BRANCH == "master" ]]; then
#     return 0
#   fi
#   return 1
# }

# function build_passed {
#   if [[ "$WERCKER_RESULT" = "passed" ]]; then
#     return 0
#   fi
#   return 1
# }

# function is_deploy {
#   if [[ ! -n "$DEPLOY" ]]; then
#     return 0
#   fi
#   return 1
# }

# function build_time {
#   return ($WERCKER_MAIN_PIPELINE_FINISHED - $WERCKER_MAIN_PIPELINE_STARTED)
# }

# function publish_metric {
#   curl \
#     -u "$LIBRATO_USER":"$LIBRATO_TOKEN" \
#     -d "display_name='$1'&attributes[$2]=$3" \
#     -X PUT \
#     'https://metrics-api.librato.com/v1/metrics/test'
# }

# if [[ on_master_branch && build_passed ]];
# then
#   publish_metric "CI Build Time", 'build_time', build_time
# else
#   info "Skipping..."
# fi
