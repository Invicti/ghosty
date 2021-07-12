#!/bin/bash
export GHOSTY_VERSION="1.0.6"

set +x #set to -x to trace this script on the console.
echo "executing in: "`pwd`
#this is where we check for input variables sent to the Ghost instance.
bold=$(tput bold)
normal=$(tput sgr0)
echo "${bold}Ghosty version:$GHOSTY_VERSION${normal}"

set -e

# set url_proto to https:// as default if using your own proxy and certificates, 
# otherwise leave it alone or it will break the internal links.
if [[ "$GHOST_URL_PROTO" == "" ]] 
then
    url_proto="http://"
else
    url_proto=$GHOST_URL_PROTO
fi 





    if [[ "$GHOSTY_DB__RESET" == "1" ]]
    then
      echo "${bold}Ghosty has been requested to delete the database file currently configured. \
      Do not forget to change the GHOSTY_DB__RESET parameter back to 0 or it will reset your site at each restart.
      ${normal}IF your are using MYSQL database it must be deleted by MYSQL administrator. This is only for the default database set by Ghosty for Ghost."
      $GHOST_DATABASE_CONNECTION__FILENAME
      if test -f "$GHOST_DATABASE_CONNECTION__FILENAME"; then
        echo "${bold}Ghosty Info: sqllite3 database exists: $GHOST_DATABASE_CONNECTION__FILENAME."
      else
        echo "${bold}Ghosty Info: sqllite3 database DOES NOT exists: $GHOST_DATABASE_CONNECTION__FILENAME."
      fi
    else
      echo "${bold}Ghosty database file already exists. Left untouched."
    fi




if [[ "$GHOST_HOSTNAME" == "" ]] 
then
    echo "${bold}Ghost Host name is empty. Will set it to localhost."
fi 

echo "Host name is: ${GHOST_HOSTNAME}"

if [[ "$GHOST_HOSTNAME" == "localhost" ]] 
then
    GHOST_HOSTNAME="localhost"
    port_def=":2368"
else
    port_def=""
fi 
echo "${normal}Host name refactored to: ${GHOST_HOSTNAME}"
echo "${normal}Port definition refactored to: ${port_def}"

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

cat >/opt/ghosty/Ghost/core/shared/config/env/config.development.json<<EOF
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



printenv
    echo "${bold}Ghosty just got in."
    echo "${bold} Ghosty is overriding Ghost default configuation, Ghosty configuration for Ghost is:"

    cat /opt/ghosty/Ghost/core/shared/config/env/config.development.json

    echo "${bold}Press [CTRL+C] to stop autostart..."

    

    if [ $NGROK == 1 ]

    then
            echo "${bold}NGROK autostart is on."
            echo "Now setting up an ephemaral public url to share."
            #set +e 
            which ngrok
            ngrok http 2368 -config=/opt/ghosty/ngrok.conf > /data/ngrok.log &
            #set -e 
            sleep 1
            NGROK_HOSTNAME=$(curl --silent --show-error http://0.0.0.0:4040/api/tunnels | sed -nE 's/.*public_url":"https:..([^"]*).*/\1/p')
            echo "${bold}Ghosty is now starting Ghost on https://$NGROK_HOSTNAME"
            port_def=""
            url_proto="https://"
            echo "URL proto now: ${url_proto}"
            # export url="${url_proto}${NGROK_HOSTNAME}" 
            GHOST_HOSTNAME=${NGROK_HOSTNAME}

     fi

            # add in launchmd if needed.
            # DEBUG=ghost-config \
            # NODE_ENV=development \
            # ${ghost_env_group_database} \
            echo `pwd`
            launchcmd=" \
            cd /opt/ghosty/Ghost; ls /opt/ghosty/Ghost/package.json;
            url=${url_proto}${GHOST_HOSTNAME}${port_def} \
            nohup node index > /data/ghosty.log & \
            #> /dev/null &"
            eval $launchcmd
            sleep 1 
       #report launch conditions.     
       if [ $NGROK == 0 ]
       then
           echo "${bold}Ghosty's mission complete, Ghost is listening on ${url_proto}${GHOST_HOSTNAME} . Control C to exit."

       else
            echo "${normal}Ghosty's mission complete, Ghost is listening on \
             ${bold}${url_proto}${GHOST_HOSTNAME}${port_def}${normal} . \
             ${normal}Please make sure this host name is associated with an accessible IP before you try this URL out.
             Control C to exit."
       fi
    

    trap 'trap - INT; kill "$!"; exit' INT
    #exec tail -f /dev/null & wait $!
    exec tail -f /data/ghosty.log #& wait $!
