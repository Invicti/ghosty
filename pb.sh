#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
PUSH_REPOSITORY=docker.io
IMAGE=invictieu/ghosty
<<<<<<< Updated upstream
VERSION=0.1.0
=======
VERSION=0.1.5
#docker container rm /ghosty
>>>>>>> Stashed changes
docker build . -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest
docker push ${PUSH_REPOSITORY}/${IMAGE}:${VERSION}
docker push ${PUSH_REPOSITORY}/${IMAGE}:latest
docker run -e "NGROK=1" -e "GHOST_HOSTNAME=" -ti  -p 2368:2368 -p 5555:5555 ${PUSH_REPOSITORY}/${IMAGE}:${VERSION} sh
