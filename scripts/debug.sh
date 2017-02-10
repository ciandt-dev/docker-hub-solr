#!/usr/bin/env bash

: ' Runs a Docker container and attaches stdout/stderr to host machine

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)

# run container and attach stdout/stderr
"${DOCKER}" run --name "${DOCKER_CONTAINER_NAME}" \
                --tty \
                --attach stdout \
                --attach stderr \
                --env-file \
                  "conf/"${APP_NAME}"."${ENVIRONMENT}".env" \
                ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}""
