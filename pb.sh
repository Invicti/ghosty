#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
docker build . -t invictieu/ghosty:0.1.0 -t latest
docker push invictieu/ghosty:0.1.0 
docker run -e "NGROK=1" -e "GHOST_HOSTNAME=" -ti  -p 2368:2368 -p 5555:5555 invictieu/ghosty:0.1.0 sh
