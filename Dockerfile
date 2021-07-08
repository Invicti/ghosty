FROM ubuntu
EXPOSE 2368:2368/tcp
EXPOSE 5555:5555/tcp
EXPOSE 9229:9229/tcp
EXPOSE 4040:4040/tcp
ARG ENV_NGROK
ENV NGROK=$ENV_NGROK
RUN  apt-get -y update
RUN  apt-get -y install software-properties-common
#RUN  add-apt-repository ppa:certbot/certbot
#RUN  apt-get install software-properties-common
RUN  apt-get -y  install certbot
RUN  apt-get -y install make
RUN  apt-get -y install curl
RUN  apt-get -y  install build-essential g++
RUN  apt-get -y install python
RUN  curl -sL https://deb.nodesource.com/setup_16.x |  bash -
RUN  apt-get -y install nodejs
RUN  apt-get -y install git
RUN  apt-get -y install git-core
RUN  apt-get -y install vim
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
RUN git clone --recurse-submodules https://github.com/Invicti/Admin.git
RUN git clone --recurse-submodules https://github.com/Invicti/Ghost.git
WORKDIR "/Admin"
RUN git remote rename origin upstream
RUN git remote add origin https://github.com/Invicti/Ghost.git
RUN git pull
WORKDIR "/Ghost"
RUN git remote rename origin upstream
RUN git remote add origin https://github.com/Invicti/Admin.git
RUN git checkout main 
RUN git pull upstream main
RUN yarn setup
COPY start.sh . 
COPY ngrok.conf .
RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]
CMD ["true", "batman", "superman"]
