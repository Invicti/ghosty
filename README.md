# ghosty
Ghosty, based on the famous Ghost blog project, lets you host your blog on your own computer at home or hosted anywhere under your control.
All over the world, people have started 2,000,000+ incredible sites with Ghost.
You can try the hosted version at https://ghost.org or run it on your own and read on a few simple steps.
I have been exploring with a bunch of Docker install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.

Docker must be installed and running on your machine.

Quick start:

1) Build the docker file: `docker build . -t invicti/ghosty `
2) Run the docker file: `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`
3) Browse to: http://localhost:2368 and to admin your Ghost site browse to: http://localhost:2368/ghost
4) Now say you want to show your friends, all you have to do is look at the address displayed by ngrok after launch is complete. The address containing ngrok.io is the public URL to your new Ghost site:
```
Forwarding                    http://c5e8b7878858.ngrok.io -> http://localhost:2368              
Forwarding                    https://c5e8b7878858.ngrok.io -> http://localhost:2368
```

This address will change next time you run `docker run...` so if you want to keep the same address you can pay a small monthly fee to ngrok and they will provide you with a fixed URL and will even terminate your connection with ssl certificates so you don't have to do deal with it.

Developer corner: The `docker build` command will pull the latest version of Ghost source code from a cloned repository that keeps the Ghost repository as its upstream. So the source code for Ghost is available to you in the running Docker. To access it you simply run `docker exec -ti [containerID] sh` from another terminal window after your run the previous steps from a first terminal window (This way you don't have to stop the running Ghost server). More information for advanced users is available here https://github.com/Invicti/Ghost.
If you want to disable ngrok simply edit the start.sh file and comment out the line starting by ngrok (Prefix the line with #) and run the `docker build . -t invicti/ghosty` command and again and `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`.

That's it for now!

Enjoy Ghost!
