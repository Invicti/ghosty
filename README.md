# Ghosty


All over the world, people have started 2,000,000+ incredible sites with Ghost.
You can try the hosted version at https://ghost.org or run it on your own and read on a few simple steps.

Ghosty is a one command deploy for your home based Ghost blog project that will produce a sharable web URL for people to read your blog or even own their own blog. You will not pay for any hosting fees if you don't want to, because your computer is the host. And now you do not need any fixed IP address, know what it is, or any geeky knowledge to make it happen, thanks to Ghosty.


I have been exploring with a bunch of  install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.
Docker must be installed and running on your machine.

## Quick start

From the Ghost directory, at the shell prompt, run `./startup.sh`.

Instructions to try out your new site will appear on the screen.

> This address will change next time you run `docker run...` so if you want to keep the same address you can pay a small monthly fee to ngrok and they will provide you with a fixed URL and will even terminate your connection with ssl certificates so you don't have to do deal with it.

## Developer's tricks
The `docker build` command will pull the latest version of Ghost source code from a cloned repository that keeps the Ghost repository as its upstream. So the source code for Ghost is available to you in the running Docker. To access it you simply run `docker exec -ti [containerID] sh` from another terminal window after your run the previous steps from a first terminal window (This way you don't have to stop the running Ghost server). More information for advanced users is available here https://github.com/Invicti/Ghost.
If you want to disable ngrok simply edit the start.sh file and comment out the line starting by ngrok (Prefix the line with #) and run the `docker build . -t invicti/ghosty` command and again and `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`.

That's it for now!

Enjoy Ghost!
