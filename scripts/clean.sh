#!/usr/bin/env bash

: ' Stops a running Docker container, delete it and remove its Docker image

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)

# clean message
echo -e "\n  _______________________________________________________________________________\n"
echo -e "\n  -- Docker Clean\n\n  Cleaning up\n  Please wait..."

# stop running Docker container
echo -en "\n  Stopping Docker container: "
"${DOCKER}" stop \
            "${DOCKER_CONTAINER_NAME}"

# remove Docker container
echo -en "\n\n  Removing Docker container: "
"${DOCKER}" rm \
            --force \
            "${DOCKER_IMAGE_NAME}"

# remove Docker image
echo -en "\n\n  Removing Docker image: "
"${DOCKER}" rmi \
            --force \
            "${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}"

# clean successful
echo -e "\n  _______________________________________________________________________________\n"
