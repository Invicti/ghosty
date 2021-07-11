#!/bin/bash
set +x #set to -x to trace this script on the console.

#this is where we check for input variables sent to the Ghost instance.
[[ -z $ENV_GHOST_MAIL__TRANSPORT ]] && m1="mail_transport=SMTP" || m1="mail_transport=$ENV_GHOST_MAIL__TRANSPORT"
[[ -z $ENV_GHOST_MAIL__OPTIONS__SERVICE ]] && m2="mail__options__service=" || m2="mail__options__service=$ENV_GHOST_MAIL__OPTIONS__SERVICE"
[[ -z $ENV_GHOST_MAIL__OPTIONS__PORT ]] && m3="mail__options__port=2525" || m3="mail__options__port=$ENV_GHOST_MAIL__OPTIONS__PORT"
[[ -z $ENV_GHOST_MAIL__OPTIONS__HOST ]] && m4="mail__options__host=smtp.mailtrap.io" || m4="mail__options__host=$ENV_GHOST_MAIL__OPTIONS__HOST"
[[ -z $ENV_GHOST_MAIL__OPTIONS__SECURE_CONNECTION ]] && m5="mail__options__secure_connection=STARTTLS" || m5="mail__options__secure_connection=$ENV_GHOST_MAIL__OPTIONS__SECURE_CONNECTION"
[[ -z $ENV_GHOST_MAIL__OPTIONS__AUTH__USER ]] && m6="mail__options__auth__user=e9ce845b5a0d8c" || m6="mail__options__auth__user=$ENV_GHOST_MAIL__OPTIONS__AUTH__USER"
[[ -z $ENV_GHOST_MAIL__OPTIONS__AUTH__PASS ]] && m7="mail__options__auth__pass=1fd040592ff7c8" || m7="mail__options__auth__pass=$ENV_GHOST_MAIL__OPTIONS__AUTH__PASS"
[[ -z $ENV_GHOST_MAIL__FROM ]] && m8="mail__from=from@example.com" || m8="mail__from=$ENV_GHOST_MAIL__FROM"

[[ -z $GHOST_MAIL__TRANSPORT ]] && m1="mail_transport=SMTP" || m1="mail_transport=$GHOST_MAIL__TRANSPORT"
[[ -z $GHOST_MAIL__OPTIONS__SERVICE ]] && m2="mail__options__service=" || m2="mail__options__service=$GHOST_MAIL__OPTIONS__SERVICE"
[[ -z $GHOST_MAIL__OPTIONS__PORT ]] && m3="mail__options__port=2525" || m3="mail__options__port=$GHOST_MAIL__OPTIONS__PORT"
[[ -z $GHOST_MAIL__OPTIONS__HOST ]] && m4="mail__options__host=smtp.mailtrap.io" || m4="mail__options__host=$GHOST_MAIL__OPTIONS__HOST"
[[ -z $GHOST_MAIL__OPTIONS__SECURE_CONNECTION ]] && m5="mail__options__secure_connection=STARTTLS" || m5="mail__options__secure_connection=$GHOST_MAIL__OPTIONS__SECURE_CONNECTION"
[[ -z $GHOST_MAIL__OPTIONS__AUTH__USER ]] && m6="mail__options__auth__user=e9ce845b5a0d8c" || m6="mail__options__auth__user=$GHOST_MAIL__OPTIONS__AUTH__USER"
[[ -z $GHOST_MAIL__OPTIONS__AUTH__PASS ]] && m7="mail__options__auth__pass=1fd040592ff7c8" || m7="mail__options__auth__pass=$GHOST_MAIL__OPTIONS__AUTH__PASS"
[[ -z $GHOST_MAIL__FROM ]] && m8="mail__from=from@example.com" || m8="mail__from=$GHOST_MAIL__FROM"
set -u #exit if undefined variables.
ghost_env_group_email=${m1}" "${m2}" "${m3}" "${m4}" "${m5}" "${m6}" "${m7}" "${m8}
eval  $ghost_env_group_email printenv
# ghost_env_group_email="mail_transport=${ENV_GHOST_MAIL__TRANSPORT:'SMTP'} \
# mail__options__service=${ENV_GHOST_MAIL__OPTIONS__SERVICE:'SMTP'} \
# mail__options__port=$ENV_GHOST_MAIL__OPTIONS__PORT:'2525'} \
# mail__options__host=$ENV_GHOST_MAIL__OPTIONS__HOST:'smtp.mailtrap.io'} \
# mail__options__secure_connection=$ENV_GHOST_MAIL__OPTIONS__SECURE_CONNECTION:'STARTTLS'} \
# mail__options__auth__user=$ENV_GHOST_MAIL__OPTIONS__AUTH__USER:'e9ce845b5a0d8c'} \
# mail__options__auth__pass=$ENV_GHOST_MAIL__OPTIONS__AUTH__PASS:'1fd040592ff7c8'} \
# mail__from=$ENV_GHOST_MAIL__FROM:'from@example.com'}"




