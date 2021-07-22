#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
#Mysql not activated here yet so please leave the sqlite3 option untouched for now and
#wait a few days if you need mysql support.

RED=$(tput -Txterm setaf 1)
GRN=$(tput -Txterm setaf 2)
YLW=$(tput -Txterm setaf 3)
RST=$(tput -Txterm sgr0)
BLD=$(tput bold)

export oldID="notimplementedyet"
export newID=$RANDOM
VOLUME_CODE="ghost_data_code_$newID"
VOLUME_DATA="ghost_data_prod_$newID"
echo "Naming new Ghost installation process: ghosty-$newID"
echo "Please wait..."
if [[ $(which docker) && $(docker --version) ]]; then
    echo "Docker is available. Continuing with Ghosty."
    # command
  else
    echo "Docker is required. Please visit docker.io and install first (README includes more details)."
    # command
fi
set -x
docker stop ghosty-$oldID

PUSH_REPOSITORY=docker.io/
IMAGE=invictieu/ghosty
VERSION=0.1.9
# add no --no-cache to build if some files need to be replaced fresh. This does not count for the files on docker volumes.
# use this command to run inside the docker if any issue arise: \
# docker run -ti  --entrypoint sh  --mount src=_data,target=/data,type=volume --mount src=ghost-$newID_code2,target=/opt/ghosty,type=volume invictieu/ghosty:0.1.7

echo "version $VERSION"
# Uncomment next line to simply rebuild Ghost running image from the downloaded source.
# docker build .  -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest #add -no-cache if needed.
# lines below will not work if volumes were created from a previous launch and still linked to a container.
# docker volume rm -f ghost-$newID_data
# docker volume rm -f ghost-$newID_code
# docker rm -f ghosty-$newID
# add (if you have no proxy): --publish-all=true \
docker run \
-d \
-e "NGROK=1" \
-e "GHOST_URL_PROTO=http://" \
-e "GHOST_HOSTNAME=localhost" \
-e "GHOST_MAIL__TRANSPORT=SMTP" \
-e "GHOST_MAIL__OPTIONS__SERVICE=" \
-e "GHOST_MAIL__OPTIONS__PORT=2525" \
-e "GHOST_MAIL__OPTIONS__HOST=smtp.mailtrap.io" \
-e "GHOST_MAIL__OPTIONS__SECURE_CONNECTION=" \
-e "GHOST_MAIL__OPTIONS__AUTH__USER=e9ce845b5a0d8c" \
-e "GHOST_MAIL__OPTIONS__AUTH__PASS=1fd040592ff7c8" \
-e "GHOST_MAIL__FROM=email@example.com" \
-e "GHOST_DATABASE_CLIENT=sqlite3" \
-e "GHOST_DATABASE_CONNECTION__HOST=" \
-e "GHOST_DATABASE_CONNECTION__USER=" \
-e "GHOST_DATABASE_CONNECTION__PASSWORD=" \
-e "GHOST_DATABASE_CONNECTION__FILENAME=/data/ghost-test.db" \
-e "GHOST_DATABASE_CONNECTION__DATABASE=ghost" \
-e "GHOST_DB_RESET=0" \
-e "GHOST_DEFAULT_PORT=2368" \
--expose "4040" \
--expose "2368" \
-P \
-v $VOLUME_DATA:/data \
-v $VOLUME_CODE:/opt/ghosty \
--name ghosty_$newID \
${PUSH_REPOSITORY}${IMAGE}:${VERSION}
#sh \
# -ti  \
docker logs -f ghosty_$newID