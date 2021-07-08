#!/bin/bash
set -x
while $1
do
    echo "Press [CTRL+C] to stop.."
    sleep 5
    echo "Ghosty just go in, now starting up in its container."
    yarn start &
    ngrok http 2368 
done
