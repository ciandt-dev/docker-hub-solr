#!/usr/bin/env bash

: ' Runs Docker container and connects to its shell (BASH)

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)

# variables
SHELL_TYPE="bash"

# shell message
echo -e "\n  Connecting to Docker container shell...\n"

# get docker container shell
"${DOCKER}" exec \
            --interactive \
            --tty \
            "${DOCKER_CONTAINER_NAME}" \
            "${SHELL_TYPE}"
