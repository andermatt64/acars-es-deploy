#!/bin/bash

MAX_MAP_COUNT=$(sysctl -n vm.max_map_count)
TARGET_MAP_COUNT=262144

if [ ! "${MAX_MAP_COUNT}" = "${TARGET_MAP_COUNT}" ]; then
  printf "Setting vm.max_map_count to ${TARGET_MAP_COUNT}\n"
  sudo sysctl -w vm.max_map_count=${TARGET_MAP_COUNT} >/dev/null
fi
  
printf "vm.max_map_count already set to ${TARGET_MAP_COUNT}\n"
