#!/bin/bash
set +x #set to -x to trace this script on the console.

#this is where we check for input variables sent to the Ghost instance.
bold=$(tput bold)
normal=$(tput sgr0)

export port_def=""

[[ $GHOST_HOSTNAME=="localhost" ]] && GHOST_HOSTNAME="localhost"; port_def=":2368" || GHOST_HOSTNAME=$GHOST_HOSTNAME; ; port_def=""
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
    echo "Ghosty just got in."
    echo "Environment variables are set as follow: $ghost_env_group_email"

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

            #Ghost startup.
            export url="https://${NGROK_HOSTNAME}" 
            GHOST_HOSTNAME=${NGROK_HOSTNAME}
            port_def=""
            #nohup yarn start > ghosty.log &#> /dev/null &
     fi

            # add in launchmd if needed.
            # DEBUG=ghost-config \
            # NODE_ENV=development \
            # ${ghost_env_group_database} \

            launchcmd=" \
            url=http://${GHOST_HOSTNAME}${port_def} \
            nohup yarn start > ghosty.log & \
            #> /dev/null &"
            eval $launchcmd
            sleep 1 
       if [ $NGROK == 0 ]
       then
           echo "${bold}Ghosty's mission complete, Ghost is listening on https://${GHOST_HOSTNAME} . Control C to exit."

       else
            echo "${bold}Ghosty's mission complete, Ghost is listening on http://${GHOST_HOSTNAME}${port_def} . Control C to exit."
       fi
    

    trap 'trap - INT; kill "$!"; exit' INT
    #exec tail -f /dev/null & wait $!
    exec tail -f ./ghosty.log #& wait $!
