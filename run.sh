#!/bin/sh +xe

ls -al

source ./support/wercker-functions.sh
source ./support/librato-functions.sh

# TODO: check for librato credentials here...

# build time
if [[ !is_deploy ]];
then
  add_counter 'build_time' build_time branch_name
fi

publish
