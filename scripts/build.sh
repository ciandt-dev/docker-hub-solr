#!/usr/bin/env bash

: ' Builds Docker image using variables from .env file and also provides a
    detailed status output message

    TODO : Improve how to retrieve information from Docker inspect in Maintainers list

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)
CAT=$(which cat)

# timestamp for Docker tag
DOCKER_IMAGE_TAG=$(date +%Y%m%d%H%M%S)

# build Docker image
"${DOCKER}" build \
            --tag \
              ""${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}"" \
            --tag \
              ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}"" \
            --file app/Dockerfile \
            app

# print messages if docker run was successful or not
if [ $? -eq 0 ]; then

  # change bash parameter
  set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)

  # get Docker image vendor label
  readonly DOCKER_LABEL_VENDOR=$( \
    "${DOCKER}" inspect \
                --format \
                  '{{ index .Config.Labels "com.ciandt.vendor" }}' \
                --type \
                  image \
                ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}""
                )

  # get Docker image maintainer 1 label
  readonly DOCKER_LABEL_MAINTAINER_1=$( \
    "${DOCKER}" inspect \
                --format \
                  '{{ index .Config.Labels "com.ciandt.maintainers.1" }}' \
                --type \
                  image \
                ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}""
                )

  # get Docker image maintainer 2 label
  readonly DOCKER_LABEL_MAINTAINER_2=$( \
    "${DOCKER}" inspect \
                --format \
                  '{{ index .Config.Labels "com.ciandt.maintainers.2" }}' \
                --type \
                  image \
                ""${DOCKER_IMAGE_NAME}":"${DOCKER_DEFAULT_TAG}""
                )

  "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Build

  Your Docker image is built

  Vendor: "${DOCKER_LABEL_VENDOR}"

  Maintainers: "${DOCKER_LABEL_MAINTAINER_1}"
               "${DOCKER_LABEL_MAINTAINER_2}"

  Docker image name: "${DOCKER_IMAGE_NAME}"

  Tags: "${DOCKER_IMAGE_TAG}"
        "${DOCKER_DEFAULT_TAG}"

  _______________________________________________________________________________

EOM

else

  "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Build

  ERROR!!
  Something happened, your Docker image was not built
  _______________________________________________________________________________

EOM

  exit 1

fi
