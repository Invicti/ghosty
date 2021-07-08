# ghosty
Ghosty lets you deploy your blog of your own, based on the famous Ghost blog project.
I have been exploring with a bunch of Docker install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.

Docker must be installed and running on your machine.

Quick start:

1) Build the docker file: `docker build . -t invicti/ghosty `
2) Run the docker file: `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`
4) Browse to: http://localhost:2368 and to admin your Ghost site browse to: http://localhost:2368/ghost

That's it for now!

Enjoy Ghost!
