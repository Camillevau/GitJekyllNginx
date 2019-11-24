# GitJekyllNginx

This is a solution to rapidly deploy a static website with git, [Jekyll][2], [Nginx][3] and [Docker][4]

## Concepts

Jekyll is a wide spread static website generator, used by github hosting.

Docker is a bundler. Here we use the [multi stage][5] concept, really powerfull compared with former way of doing it (dig this repos history, it was awefull ).

Nginx is a webserver to serve the website.

## How To

Paste this Dockerfile into your jekyll repo

```bash

docker build -t website_name .

docker run -p80:80 website_name

```

et voila !

## Notes

If you want more specialised Jekyll images, [envygeeks/jekyll-docker][6] distributes them.

If you want to tweak more the nginx image, follow [these instructions][7].

## TODO

Previous versions of this repo contain a post commit hook used to deploy the container on a simple server to enable continuous deployment without any Jenkins or similiar huge tool. I should dig this up and improve this first draft. A simple config file for container name and port mapping should do the trick.

## License

This application is distributed under the [Apache License, Version 2.0][1].

[1]: http://www.apache.org/licenses/LICENSE-2.0
[2]: http://jekyllrb.com
[3]: http://nginx.com
[4]: http://docker.com
[5]: https://docs.docker.com/develop/develop-images/multistage-build/
[6]: https://github.com/envygeeks/jekyll-docker
[7]: https://hub.docker.com/_/nginx
