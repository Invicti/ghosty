#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
PUSH_REPOSITORY=docker.io
IMAGE=invictieu/ghosty
VERSION=0.2.1
docker build . -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest
docker push ${PUSH_REPOSITORY}/${IMAGE}:${VERSION}
docker push ${PUSH_REPOSITORY}/${IMAGE}:latest

