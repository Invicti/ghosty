# ghosty
Ghosty lets you deploy your blog of your own, based on the famous Ghost blog project.
I have been exploring with a bunch of Docker install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.

Quick start:

1) Build the docker file: ` docker build . -t fodor/tools:0.1.0 `
2) Then run the docker file (expose the ports to acces from your local machine): ` docker build . -t invicti/ghosty:0.1.0`
3) Run the docker on your machine (Yes! you got to have Docker installed to try it out on your machine): `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`
4) Browse to: http://localhost:2368 and to admin your Ghost site browse to: http://localhost:2368/ghost

That's it for now!

Enjoy Ghost!
