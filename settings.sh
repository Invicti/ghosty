c#!/bin/bash
set -x #set to -x to trace this script on the console.

cp ./config.development.json ./config.development.json.backup

$(jq --null-input --arg user "$USERNAME" --arg password "$PASSWORD" '{"user": $user, "password": $password}')


 SETTINGS=$(jq --null-input  \
 --arg user pop \
'{
                enableDeveloperExperiments: true,
                database: {
                    client: "mysql",
                    connection: {
                        host: "127.0.0.1",
                        user: "root",
                        password: "transport",
                        database: "ghost"
                    }
                },
                server: {
                    host: "0.0.0.0",
                    port: 2368
                },
                mail: {
                    from: $GHOST_MAIL__FROM,
                    transport: $GHOST_MAIL__TRANSPORT,
                    options: {
                        host: $GHOST_MAIL__OPTIONS__HOST,
                        port: $GHOST_MAIL__OPTIONS__PORT,
                        auth: {
                            user: $GHOST_MAIL__OPTIONS__AUTH__USER,
                            pass: $GHOST_MAIL__OPTIONS__AUTH__PASS
                        }
                    }
                }
            }')

            # if jq -e . >/dev/null 2>&1 <<<"$default_config_json"; then
            #         echo "Parsed JSON successfully and got something other than false/null"
            #     else
            #         echo "Failed to parse JSON, or got false/null"
            #         exit;
            #     fi

node -p "JSON.stringify('{ "enableDeveloperExperiments": true, \
"database": { "client": "mysql", "connection": { "host": "127.0.0.1", \
"user": "root", "password": "", "database": "ghost" } }, "server": { "host": "0.0.0.0", "port": 2368 },\
# "mail": { "from": nfodor@gmail.com, "transport": SMTP, "options": \
# { "host": "smtp.mailtrap.io", "port": 2525, \
# "auth": { "user": e9ce845b5a0d8c, "pass": 1fd040592ff7c8 }}}}
', key4: 'value4'}, null, 2)" > ./test.json


node -p "JSON.stringify('{ "enableDeveloperExperiments": true, "database": { "client": "mysql", "connection": { "host": "127.0.0.1", "user": "root", "password": "", "database": "ghost" } }, "server": { "host": "0.0.0.0", "port": 2368 }, "mail": { "from": nfodor@gmail.com, "transport": SMTP, "options": { "host": smtp.mailtrap.io, "port": 2525, "auth": { "user": e9ce845b5a0d8c, "pass": 1fd040592ff7c8 }}}}
', key4: 'value4'}, null, 2)" > ./test.json

node -p "JSON.stringify('{ "enableDeveloperExperiments": true, {'key4: 'value4'}, null, 2)" > ./test.json


node -p "JSON.stringify('{ "enableDeveloperExperiments": true}, \
"database": \
{ "client": "mysql", \
"connection": \
{ "host": "127.0.0.1", \
"user": "root", \
"password": "", \
"database": "ghost" } }, \
"server": \
{ "host": "0.0.0.0", "port": 2368 },\
"mail": \
{ "from": nfodor@gmail.com, \
"transport": SMTP, \
"options": \
{ "host": "smtp.mailtrap.io", \
"port": 2525, \
"auth": { "user": e9ce845b5a0d8c, \
"pass": 1fd040592ff7c8 }}}} \
')"  > ./test2.json