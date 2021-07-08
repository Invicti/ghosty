#!/bin/bash
set +x #set to -x to trace this script on the console.

    echo "Press [CTRL+C] to stop autostart..."
    echo "Ghosty just got in, now setting up an ephemaral public url to share."
    set +e #keep running even if ngrok not available
    ngrok http 2368 -config=./ngrok.conf > /dev/null &
    sleep 1 
    NGROK_HOSTNAME=$(curl --silent --show-error http://0.0.0.0:4040/api/tunnels | sed -nE 's/.*public_url":"https:..([^"]*).*/\1/p')
    echo "${bold}Ghosty is now starting Ghost on https://$NGROK_HOSTNAME"
    set -e #Quit if yarn issues.
    nohup yarn start > ghosty.log > /dev/null &
    sleep 1 
    echo "${bold}Ghosty's mission complete, Ghost is listening on https://$NGROK_HOSTNAME. Control C to exit."

    trap 'trap - INT; kill "$!"; exit' INT
    exec tail -f /dev/null & wait $!
