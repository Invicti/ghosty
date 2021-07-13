#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
#Mysql not activated here yet so please leave the sqlite3 option untouched for now and
#wait a few days if you need mysql support.
docker stop ghosty
PUSH_REPOSITORY=docker.io/
IMAGE=invictieu/ghosty
VERSION=0.1.7
# add no --no-cache to build if some files need to be replaced fresh. This does not count for the files on docker volumes.
# use this command to run inside the docker if any issue arise: \
# docker run -ti  --entrypoint sh  --mount src=ghost_data2,target=/data,type=volume --mount src=ghost_code2,target=/opt/ghosty,type=volume invictieu/ghosty:0.1.7

echo "version $VERSION"

docker build .  -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest #add -no-cache if needed.
# lines below will not work if volumes were created from a previous launch and still linked to a container.
# docker volume rm -f ghost_data
# docker volume rm -f ghost_code
docker rm -f ghosty
docker run \
-e "NGROK=0" \
-e "GHOST_URL_PROTO=https://" \
-e "GHOST_HOSTNAME=ghost.fodor.net" \
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
-ti  \
-p 2368:2368 \
-p 4040:4040 \
--mount src=ghost_data_prod,target=/data,type=volume \
--mount src=ghost_code2_prod,target=/opt/ghosty,type=volume \
--name ghosty \
${PUSH_REPOSITORY}${IMAGE}:${VERSION} \
sh
