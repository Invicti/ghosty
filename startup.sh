#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
docker build . -t fodor/tools:0.1.0
docker run -ti  -p 2368:2368 -p 5555:5555 fodor/tools:0.1.0 sh