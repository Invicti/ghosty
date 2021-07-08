#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
docker build . -t invicti/ghosty:main
docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:main sh