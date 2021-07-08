# Ghosty


All over the world, people have started 2,000,000+ incredible sites with [Ghost](https://ghost.org).

You can try the hosted version free at [Ghost](https://ghost.org) or pay for it to open options.

Or try Ghosty:

Ghosty is "Instant independant deployement of professional free expression". 

Ghostly will produce a sharable web URL for people to read your blog or even own their own blog. 

You will not pay for any hosting fees if you don't want to, because your computer is the host. 

(You do not need any fixed IP address, know what it is, or any geeky knowledge to make it happen)

![Image of Ghost Site](https://user-images.githubusercontent.com/120485/66918181-f88fdc80-f048-11e9-8135-d9c0e7b35ebc.png)
	

I have been exploring with a bunch of  install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.


## Quick start

### Pull and run the container

Make sure docker is installed and type the following in your terminal:

```bash
docker pull ghcr.io/invicti/ghosty:main
docker run -ti  -p 2368:2368 -p 5555:5555 -p 4040:4040 invicti/ghosty:main sh
```
Instructions to try out your new site will appear on the screen (the URL will be different):
```bash
Ghosty's mission complete, Ghost is listening on https://2733bef2191a.ngrok.io. Control C to exit.
```

Note: The docker file is generated automatically by Github based on the latest main branch of this repository. So this is the way to go if all you care about is running a Ghost server and publish it to the world immediately.
If you are more interested in using Ghosty as an entry point to the latest development version of Ghost it would be more interesting to follow the next step to run Ghosty, it is greatly simplified.


### From source after you clone this project.

First clone this project, and from the Ghost directory, at the shell prompt, run `./startup.sh`.

Instructions to try out your new site will appear on the screen (the URL will be different):
```bash
Ghosty's mission complete, Ghost is listening on https://2733bef2191a.ngrok.io. Control C to exit.
```

> This address will change next time you run `docker run...` so if you want to keep the same address you can pay a small monthly fee to ngrok and they will provide you with a fixed URL and will even terminate your connection with ssl certificates so you don't have to do deal with it.

> You can monitor traffic to your site by pointing your browser to your localhost on port 4040  https://localhost:4040

![Image of Ghost Site](ngrokStatus.pdf)

## Advanced use
The `docker build` command will pull the latest version of Ghost source code from a cloned repository that keeps the Ghost repository as its upstream. So the source code for Ghost is available to you in the running Docker. To access it you simply run `docker exec -ti [containerID] sh` from another terminal window after your run the previous steps from a first terminal window (This way you don't have to stop the running Ghost server). More information for advanced users is available here https://github.com/Invicti/Ghost.
If you want to disable ngrok simply edit the start.sh file and comment out the line starting by ngrok (Prefix the line with #).

You can execute the following steps manually, as it is now handled by the startup.sh script that you do not have to run. First build the docker file with `docker build . -t invicti/ghosty` and then run it `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`.


That's it for now!

Enjoy Ghost!
