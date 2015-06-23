StaticWebsiteGitted
======================

What is StaticWebGitted?
------

StaticWebsiteGitted is a solution to rapidly deploy a static website with git, Jekyll, Nginx and Docker

What you need
-----

 * A local gitted Jekyll website
 * A remote server with ssh, git and docker installed

What you do
-----
0.  Setup variables

this is all the variable used
<code>
export CONTAINER_NAME=webserver
export CONTAINER_PORT=
export GIT_REPO=/var/git/my_repo/
export URL=www.mywebsite.com
</code>

1.  Source set-up

 * Init a git bare repository

<code>
git init --bare $GIT_REPO
</code>

 *  add the following hook in hooks/post-receive :

<code>
#!/bin/bash
CONTAINER_NAME=webserver
echo "Received a commit on the acc server"
docker exec $CONTAINER_NAME /root/deploy.sh > /dev/null && echo "Website updated !"
</code>

 * **DO NOT FORGET

<code>
chmod u+x $GIT_REPO/hooks/post-receive

2. Run the CONTAINER_NAME :

<code>
docker run -d \
   `[ -z "$CONTAINER_PORT" ] && echo "-p $CONTAINER_PORT:80"` \
   `[ -n "$CONTAINER_PORT" ] && echo "-P"` \
   -v $GIT_REPO:/var/repository \
   -v /var/log/$CONTAINER_NAME:/var/log/nginx \
   --name $CONTAINER_NAME \
   staticwebgitted:latest
</code>

3. Configure your host proxy

* for an nginx webserver

<code>
upstream $CONTAINER_NAME {
    server 127.0.0.1:$CONTAINER_PORT;
}
server {
    listen 80;
    server_name $URL;

    location / {
        proxy_pass http://$CONTAINER_NAME;
    }
}
</code>


*******

Docker tricks
======

How to build the image
------

docker build -t staticwebgitted .

Take the hand on the server
------

docker exec -it $CONTAINER_NAME bash


*******
More
=======

Inspirations & Sources
-------

https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile
source CONTAINER_NAME

https://www.digitalocean.com/community/tutorials/how-to-deploy-jekyll-blogs-with-git
Good, but without Nginx nor Docker.. Good if you got 1 website, not if you deploy lots of them on https://www.google.com/search?client=safari&rls=en&q=heterogenous&ie=UTF-8&oe=UTF-8#q=heterogeneous environments

https://docs.docker.com/reference/builder/
https://docs.docker.com/articles/dockerfile_best-practices/
http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
A must read


Todo
--------
Add unit testing with Travis

Improve log management and infos

Propose different CONTAINER_NAMEs for different  versions of jekyll on different branches ?
=> https://github.com/jekyll/jekyll/issues/2327

Use baseimage-docker ?
=> https://github.com/phusion/baseimage-docker
=> really ? even if https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/ ?

