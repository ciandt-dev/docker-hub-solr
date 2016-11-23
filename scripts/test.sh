#!/usr/bin/env bash

: ' Tests a running Docker container

    TODO: Improve tests, maybe try to use Behat as testing tool
    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)
CURL=$(which curl)

# simple test start
echo "  _______________________________________________________________________________"
echo -e "\n  -- Docker Test - ${DOCKER_CONTAINER_NAME}\n\n  Please wait..."

# get container ip address
readonly DOCKER_CONTAINER_IP=$(\
  "${DOCKER}" inspect \
              --format \
                "{{ .NetworkSettings.Networks.bridge.IPAddress }}" \
              --type \
                container \
              "${DOCKER_CONTAINER_NAME}" \
              )

# get Docker container port
DOCKER_CONTAINER_PORT=$(\
  "${DOCKER}" exec \
                "${DOCKER_CONTAINER_NAME}" \
                bash -c 'echo "${SOLR_PORT}"' \
              )

# create a tmp file for cookie-jar
COOKIE_JAR=$(mktemp)

# disable bash errexit
set +e

# trying
"${CURL}" --silent \
          --retry 5 \
          --retry-delay 0 \
          --retry-max-time 60 \
          --cookie-jar "${COOKIE_JAR}" \
          --output /dev/null \
          http://${DOCKER_CONTAINER_IP}:${DOCKER_CONTAINER_PORT}/solr/admin

# check if was OK
if [ $? -eq 0 ]; then

  echo -e "\n  Docker container ${DOCKER_CONTAINER_NAME} service port ${DOCKER_CONTAINER_PORT}: OK!"
  echo -e "\n  _______________________________________________________________________________\n"

else

  echo -e "\n  ERROR! Docker container ${DOCKER_CONTAINER_NAME} service port ${DOCKER_CONTAINER_PORT}: NOK!"
  echo -e "\n  _______________________________________________________________________________\n"
  exit 1

fi
