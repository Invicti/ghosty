#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
#!/bin/bash
#This script will build the docker file and run Ghostly immediately after.
PUSH_REPOSITORY=docker.io
IMAGE=invictieu/ghosty
<<<<<<< Updated upstream
VERSION=0.1.0
docker build . -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest
docker run -e "NGROK=1" -e "GHOST_HOSTNAME=" -ti  -p 2368:2368 -p 5555:5555 ${PUSH_REPOSITORY}/${IMAGE}:${VERSION} sh
=======
VERSION=0.1.5
docker build . -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest
docker rm -f ghosty
docker run \
-e "NGROK=1" \
-e "GHOST_HOSTNAME=" \
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
-e "GHOST_DATABASE_CONNECTION__FILENAME=content/data/ghost-test.db" \
-e "GHOST_DATABASE_CONNECTION__DATABASE=ghost" \
-ti  \
-p 2368:2368 \
-p 4040:4040 \
--name ghosty \
${PUSH_REPOSITORY}/${IMAGE}:${VERSION} \
#sh
>>>>>>> Stashed changes
