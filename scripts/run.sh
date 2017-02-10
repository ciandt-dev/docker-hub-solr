#!/usr/bin/env bash

: ' Runs Docker container in detached mode and print a summary

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)
CAT=$(which cat)

# start run message
echo "  _______________________________________________________________________________"
echo -en "\n  -- Docker Run\n\n  Docker container is UP and RUNNING \n\n  Your Docker container ID is: "

# run docker run
"${DOCKER}" run --name "${DOCKER_CONTAINER_NAME}" \
                --env-file \
                  "conf/"${APP_NAME}"."${ENVIRONMENT}".env" \
                --detach \
                ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}""

# print messages if docker run was successful or not
if [ $? -eq 0 ]; then

  # change bash parameter
  set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)

  # get Docker container IP address
  readonly DOCKER_CONTAINER_IP=$( \
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

  "${CAT}" << EOM

  You can access Solr at:
  http://${DOCKER_CONTAINER_IP}:${DOCKER_CONTAINER_PORT}/solr/admin/

  If you prefer to use URL instead, please add it to your hosts file
  Just copy and paste the command below in your terminal or add it manually later

  sudo bash -c 'echo "${DOCKER_CONTAINER_IP} solr.local" >> /etc/hosts'

  THEN, will be able to access at:
  http://solr.local:${DOCKER_CONTAINER_PORT}

  _______________________________________________________________________________

EOM

else

  "${CAT}" << EOM

  There is already a Docker container running!!!
  Please stop and delete it before running this commmand again

  make clean

  _______________________________________________________________________________

EOM

  exit 1

fi
