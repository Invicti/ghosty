# Ghosty


All over the world, people have started 2,000,000+ incredible sites with [Ghost](https://ghost.org).

You can try the hosted version free at [Ghost](https://ghost.org) or pay for it to open options.

Or try Ghosty to run Ghost for free on your own computer with a home internet connection, and even let your friends and family try it out for free.

Ghosty is "Instant deployment for free expression" in the comfort of your own or office. 

Ghostly will produce a sharable web URL for people to read your blog or even own their own blog.
You can use your own domain name if you already have one.

You will not pay for any hosting fees if you don't want to, because your computer is the host. 

(You do not need any fixed IP address, know what it is, or any geeky knowledge to make it happen)

![Image of Ghost Site](https://user-images.githubusercontent.com/120485/66918181-f88fdc80-f048-11e9-8135-d9c0e7b35ebc.png)
	

I have been exploring with a bunch of  install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.


## Quick start

### Install Git and Docker
For instructions on how to install Git click [here](https://gist.github.com/derhuerst/1b15ff4652a867391f03)

For instructions on how to install [Docker](https://docs.docker.com/get-docker/)

Clone and run the script straight from GitHub by running this one line in your terminal (Install git and Docker first), you will see information scrolling real fast on the screen, then it will stop and provide you the URL you need.

```bash
git clone https://github.com/Invicti/ghosty.git 
cd ghosty
```
Then you can run Ghosty immediately with the default settings that you can change to your liking later.
Simply type:
```bash
./startup.sh
```
Or if you want to edit your settings before running your Ghost site, edit the startup.sh file and change the values that match your setup before you run the line above.
```bash
nano ./startup.sh
```

### Pull and run the container
Run the docker container:
<a href="https://asciinema.org/a/l38Z6W4diHGNfGqpCKrPKT4av" target="_blank"><img src="https://asciinema.org/a/l38Z6W4diHGNfGqpCKrPKT4av.svg" /></a>

Make sure docker is installed first and type the following in your terminal, you can add your own information for the email server or leave it empty and change later:
Make sure your set or remove the REPLACE_WITH field with an empty string if you do not know how set your SMTP server. It does not matter as it won't impair Ghost main features for now but only if you enable subscription to your content. (dont remove the line).

```bash
docker pull docker.io/invictieu/ghosty
docker run \
-e "NGROK=1" \
-e "GHOST_URL_PROTO=https://" \
-e "GHOST_HOSTNAME=localhost" \
-e "GHOST_MAIL__TRANSPORT=SMTP" \
-e "GHOST_MAIL__OPTIONS__SERVICE=" \
-e "GHOST_MAIL__OPTIONS__PORT=2525" \
-e "GHOST_MAIL__OPTIONS__HOST=REPLACE_WITH_YOUR_SMTP_HOST" \
-e "GHOST_MAIL__OPTIONS__SECURE_CONNECTION=REPLACE_WITH_YOUR_SMTP_CONNECTION_TYPE" \
-e "GHOST_MAIL__OPTIONS__AUTH__USER=REPLACE_WITH_YOUR_SMTP_CONNECTION_USER_NAME" \
-e "GHOST_MAIL__OPTIONS__AUTH__PASS=REPLACE_WITH_YOUR_SMTP_CONNECTION_USER_PASSWORD" \
-e "GHOST_MAIL__FROM=email@example.com" \
-e "GHOST_DATABASE_CLIENT=sqlite3" \
-e "GHOST_DATABASE_CONNECTION__HOST=" \
-e "GHOST_DATABASE_CONNECTION__USER=" \
-e "GHOST_DATABASE_CONNECTION__PASSWORD=" \
-e "GHOST_DATABASE_CONNECTION__FILENAME=/data/ghost-test.db" \
-e "GHOST_DATABASE_CONNECTION__DATABASE=ghost" \
-e "GHOST_DB_RESET=0" \
-e "mailtrain_url=" \
-e "mailtrain_configuration_id_as_int=1" \
-e "mailtrain_host=" \
-ti  \
-p 2368:2368 \
-p 4040:4040 \
--mount src=ghost_data_prod,target=/data,type=volume \
--mount src=ghost_code2_prod,target=/opt/ghosty,type=volume \
--name ghosty \
invictieu/ghosty:latest sh

```
Instructions to try out your new site will appear on the screen (the URL will be different):
```bash
Ghosty's mission complete, Ghost is listening on https://2733bef2191a.ngrok.io. Control C to exit.
```
If you know what you are doing you can send the host name to Ghost so the links are not broken in case you host it behind a proxy (and you know its assigned host name before running the container). Make sure you turn off NGROK with NGROK=0:
```bash
docker run -e "NGROK=0" -e "GHOST_HOSTNAME=yourhostname.com" -ti  -p 2368:2368 -p 5555:5555 invictieu/ghosty sh
```

You can see how it works [Here](https://asciinema.org/a/l38Z6W4diHGNfGqpCKrPKT4av)


Note: The docker file is generated automatically by Github based on the latest main branch of this repository. So this is the way to go if all you care about is running a Ghost server and publish it to the world immediately.
If you are more interested in using Ghosty as an entry point to the latest development version of Ghost it would be more interesting to follow the next step to run Ghosty, it is greatly simplified.


### From source after you clone this project.

First clone this project, and from the Ghost directory, at the shell prompt, run `./startup.sh`.

Instructions to try out your new site will appear on the screen (the URL will be different):
```bash
Ghosty's mission complete, Ghost is listening on https://2733bef2191a.ngrok.io. Control C to exit.
```

> This address will change next time you run `docker run...` so if you want to keep the same address you can pay a small monthly fee to ngrok and they will provide you with a fixed URL and will even terminate your connection with ssl certificates so you don't have to deal with it.

> You can monitor traffic to your site by pointing your browser to your localhost on port 4040  https://localhost:4040

![Image of Ghost Site](https://raw.githubusercontent.com/Invicti/ghosty/main/ngrokStatus.png)

## Advanced use
The `docker build` command will pull the latest version of Ghost source code from a cloned repository that keeps the Ghost repository as its upstream. So the source code for Ghost is available to you in the running Docker. To access it you simply run `docker exec -ti [containerID] sh` from another terminal window after your run the previous steps from a first terminal window (This way you don't have to stop the running Ghost server). More information for advanced users is available here https://github.com/Invicti/Ghost.
If you want to disable ngrok simply edit the start.sh file and comment out the line starting by ngrok (Prefix the line with #).

You can execute the following steps manually, as it is now handled by the startup.sh script that you do not have to run. First build the docker file with `docker build . -t invictieu/ghosty` and then run it `docker run -ti  -p 2368:2368 -p 5555:5555 invictieu/ghosty`.


That's it for now!

Enjoy Ghost!
