# ghosty
Ghosty lets you deploy your blog of your own, based on the famous Ghost blog project.
All over the world, people have started 2,000,000+ incredible sites with Ghost.
You can try the hosted version at or run it on your own by reading on.
I have been exploring with a bunch of Docker install file for Ghost and haven't found any that was both quick to deploy and flexible enough for development as well as production.

Docker must be installed and running on your machine.

Quick start:

1) Build the docker file: `docker build . -t invicti/ghosty `
2) Run the docker file: `docker run -ti  -p 2368:2368 -p 5555:5555 invicti/ghosty:0.1.0`
4) Browse to: http://localhost:2368 and to admin your Ghost site browse to: http://localhost:2368/ghost

Now say you want to show your friends, all you have to do is run ngrok, get it at https://ngrok.com/download.
Once ngrok is installed, to get a public URL to your site just run the following command.
`ngrok http 2368`

That's it for now!

Enjoy Ghost!
