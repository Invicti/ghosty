#!/bin/bash
set +x #set to -x to trace this script on the console.
<<<<<<< Updated upstream
=======

#this is where we check for input variables sent to the Ghost instance.
bold=$(tput bold)
normal=$(tput sgr0)
echo "Host name set to: ${GHOST_HOSTNAME}"
export port_def=""

echo "Host name is: ${GHOST_HOSTNAME}"

if [[ "$GHOST_HOSTNAME" == "localhost" ]] 
then
    GHOST_HOSTNAME="localhost"
    port_def=":2368"
else
    port_def=""
fi 
echo "Host name refactored to: ${GHOST_HOSTNAME}"
echo "Port definition refactored to: ${port_def}"

ghost_env_group_log="logging_path=ghost.log logging_level=debug "
GHOST_DEFAULT_PORT=2368

# "database": { 
#     "client": "$GHOST_DATABASE_CLIENT",
#     "useNullAsDefault" : true,
#     "connection": {
#         "host": "$GHOST_DATABASE_CONNECTION__HOST",
#         "user": "$GHOST_DATABASE_CONNECTION__USER",
#         "password": "$GHOST_DATABASE_CONNECTION__PASSWORD",
#         "database": "$GHOST_DATABASE_CONNECTION__DATABASE"
#     }
# },

# "database" : {
# "useNullAsDefault" : true,
# "debug" : false,
# "client" : "$GHOST_DATABASE_CLIENT",
# "connection" : {
#     "filename" : "$GHOST_DATABASE_CONNECTION__FILENAME"
#  }
# },
cat >./config.development.json <<EOF
{
  "enableDeveloperExperiments" : true,
  "mail" : {
    "transport" : "$GHOST_MAIL__TRANSPORT",
    "options" : {
      "auth" : {
        "pass" : "$GHOST_MAIL__OPTIONS__AUTH__PASS",
        "user" : "$GHOST_MAIL__OPTIONS__AUTH__USER"
      },
      "host" : "$GHOST_MAIL__OPTIONS__HOST",
      "port" : $GHOST_MAIL__OPTIONS__PORT
    },
    "from" : "$GHOST_MAIL__FROM"
  },
"database": { 
    "client": "$GHOST_DATABASE_CLIENT",
    "useNullAsDefault" : true,
    "connection": {
        "host": "$GHOST_DATABASE_CONNECTION__HOST",
        "user": "$GHOST_DATABASE_CONNECTION__USER",
        "password": "$GHOST_DATABASE_CONNECTION__PASSWORD",
        "database": "$GHOST_DATABASE_CONNECTION__DATABASE",
        "filename" : "$GHOST_DATABASE_CONNECTION__FILENAME"
    }
},
  "server" : {
    "host" : "0.0.0.0",
    "port" : $GHOST_DEFAULT_PORT
  }
}
EOF

cat ./config.development.json


printenv
>>>>>>> Stashed changes
    echo "Ghosty just got in."

    echo "Press [CTRL+C] to stop autostart..."
    
    if [ $NGROK == 1 ]
    then
        echo "NGROK autostart is on."
        echo "Now setting up an ephemaral public url to share."
        set +e #keep running even if ngrok not available
        ngrok http 2368 -config=./ngrok.conf > /dev/null &
        sleep 1 
        NGROK_HOSTNAME=$(curl --silent --show-error http://0.0.0.0:4040/api/tunnels | sed -nE 's/.*public_url":"https:..([^"]*).*/\1/p')
        echo "${bold}Ghosty is now starting Ghost on https://$NGROK_HOSTNAME"
        set -e #Quit if yarn issues.
        url="https://${NGROK_HOSTNAME}" nohup yarn start > ghosty.log > /dev/null &
    else

        if [ -z "$GHOST_HOSTNAME" ] 
        then
           nohup yarn start > ghosty.log > /dev/null &
           echo "${bold}Ghosty's mission complete, Ghost is listening on http://localhost:2368. Control C to exit."
        else
           url="http://${GHOST_HOSTNAME}"  nohup yarn start > ghosty.log > /dev/null &
           sleep 1 
           echo "${bold}Ghosty's mission complete, Ghost is listening on http://${GHOST_HOSTNAME}:2368. Control C to exit."
        fi


    fi

    trap 'trap - INT; kill "$!"; exit' INT
    exec tail -f /dev/null & wait $!
