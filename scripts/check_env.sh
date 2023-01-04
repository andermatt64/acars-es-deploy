#!/bin/bash

SCRIPT_PARENT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"
REPO_PATH="$(dirname "${SCRIPT_PARENT_PATH}")"
ENV_PATH="${REPO_PATH}/.env"

if [ ! -f "${ENV_PATH}" ]; then
  printf "WARNING: ${ENV_PATH} must exist with KIBANA_SYSTEM_PASSWORD defined\n"
  exit 1
fi

exit 0
