FROM ubuntu
EXPOSE 2368/tcp
#EXPOSE 5555:5555/tcp
#EXPOSE 9229:9229/tcp
EXPOSE 4040/tcp
ARG ENV_NGROK
ENV NGROK=$ENV_NGROK
ARG ENV_GHOST_HOST_PORT
ARG ENV_NGROK_ADMIN_PORT
ARG ENV_GHOST_HOSTNAME
ARG ENV_GHOST_URL_PROTO
ARG ENV_GHOST_MAIL__TRANSPORT
ARG ENV_GHOST_MAIL__OPTIONS__SERVICE
ARG ENV_GHOST_MAIL__OPTIONS__PORT
ARG ENV_GHOST_MAIL__OPTIONS__HOST
ARG ENV_GHOST_MAIL__OPTIONS__SECURE_CONNECTION
ARG ENV_GHOST_MAIL__OPTIONS__AUTH__USER
ARG ENV_GHOST_MAIL__OPTIONS__AUTH__PASS
ARG ENV_GHOST_MAIL__FROM
ARG ENV_GHOSTY_DB__RESET

ENV GHOST_HOST_PORT=$ENV_GHOST_HOST_PORT
ENV NGROK_ADMIN_PORT=$ENV_GHOST_HOST_PORT
ENV GHOST_URL_PROTO=$ENV_GHOST_URL_PROTO
ENV GHOST_HOSTNAME=$ENV_GHOST_HOSTNAME
ENV GHOST_MAIL__TRANSPORT=$ENV_GHOST_MAIL__TRANSPORT
ENV GHOST_MAIL__OPTIONS__SERVICE=$ENV_GHOST_MAIL__OPTIONS__SERVICE
ENV GHOST_MAIL__OPTIONS__PORT=$ENV_GHOST_MAIL__OPTIONS__PORT
ENV GHOST_MAIL__OPTIONS__HOST=$ENV_GHOST_MAIL__OPTIONS__HOST
ENV GHOST_MAIL__OPTIONS__SECURE_CONNECTION=$ENV_GHOST_MAIL__OPTIONS__SECURE_CONNECTION
ENV GHOST_MAIL__OPTIONS__AUTH__USER=$ENV_GHOST_MAIL__OPTIONS__AUTH__USER
ENV GHOST_MAIL__OPTIONS__AUTH__PASS=$ENV_GHOST_MAIL__OPTIONS__AUTH__PASS
ENV GHOST_MAIL__FROM=$ENV_GHOST_MAIL__FROM
ENV GHOSTY_DB__RESET=$ENV_GHOSTY_DB__RESET

ARG ENV_GHOST_DATABASE_CLIENT
ARG ENV_GHOST_DATABASE_CONNECTION__HOST
ARG ENV_GHOST_DATABASE_CONNECTION__USER
ARG ENV_GHOST_DATABASE_CONNECTION__PASSWORD
ARG ENV_GHOST_DATABASE_CONNECTION__FILENAME
ARG ENV_GHOST_DATABASE_CONNECTION__DATABASE

ENV GHOST_DATABASE_CLIENT=$ENV_GHOST_DATABASE_CLIENT
ENV GHOST_DATABASE_CONNECTION__HOST=$ENV_GHOST_DATABASE_CONNECTION__HOST
ENV GHOST_DATABASE_CONNECTION__USER=$ENV_GHOST_DATABASE_CONNECTION__USER
ENV GHOST_DATABASE_CONNECTION__PASSWORD=$ENV_GHOST_DATABASE_CONNECTION__PASSWORD
ENV GHOST_DATABASE_CONNECTION__FILENAME=$ENV_GHOST_DATABASE_CONNECTION__FILENAME
ENV GHOST_DATABASE_CONNECTION__DATABASE=$ENV_GHOST_DATABASE_CONNECTION__DATABASE

RUN  apt-get -y update
#RUN  apt-get -y install software-properties-common
#RUN  add-apt-repository ppa:certbot/certbot
#RUN  apt-get install software-properties-common
#RUN  apt-get -y  install certbot
RUN  apt-get -y install make
RUN  apt-get -y install curl
#RUN  apt-get -y  install build-essential g++
#RUN  apt-get -y install python
RUN  curl -sL https://deb.nodesource.com/setup_16.x |  bash -
RUN  apt-get -y install nodejs
RUN  apt-get -y install git
RUN  apt-get -y install git-core
RUN  apt-get -y install vim
RUN  apt-get -y install jq
RUN  npm i n -g
RUN  n 14.16.1
RUN  npm install node-pre-gyp -g
RUN  npm install --global yarn
RUN apt-get install unzip -y
RUN curl --output ngrok-stable-linux-amd64.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip 
RUN unzip ngrok-stable-linux-amd64.zip
RUN mkdir /opt/ngrok
RUN mv ngrok /usr/bin 
RUN yarn global add knex-migrator ember-cli
RUN mkdir /opt/ghosty
WORKDIR /opt/ghosty
RUN git clone --recurse-submodules https://github.com/Invicti/Ghost.git
WORKDIR "/opt/ghosty/Ghost"
RUN git remote rename origin upstream
RUN git remote add origin https://github.com/Invicti/Ghost.git
RUN git checkout main 
RUN git pull upstream main
WORKDIR "/opt/ghosty/Ghost/core/client"
RUN git remote rename origin upstream
RUN git remote add origin github.com/Invicti/Admin.git
RUN git checkout main
RUN git pull upstream main
WORKDIR "/opt/ghosty/Ghost"
RUN yarn setup
WORKDIR "/opt/ghosty"
COPY ngrok.conf "/opt/ghosty/ngrok.conf"
COPY start.sh "/opt/ghosty/start.sh"
RUN chmod +x "/opt/ghosty/start.sh"
ENTRYPOINT ["/opt/ghosty/start.sh"]
CMD ["true", "very true", "proven true"]
