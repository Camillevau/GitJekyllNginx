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
2.  Init a git bare repository
 *  add the following hook in hooks/post-receive :

#!/bin/bash
echo "Received a commit on the acc server"
 
1. Run the container :
docker run -d -p 8001:80 --volume /var/git/en.organiknowledge.com/:/var/repository -v /var/log/$MYSITE:/var/log/nginx --name server staticwebgitted:latest



How to build Container
------

CONTAINER_NAME=server
URL=en.organiknowledge.com

docker build -t staticwebgitted .

#Init bare repo

#Sart Server

docker run -d -p 8001:80 --volume /var/git/en.organiknowledge.com/:/var/repository --name server staticwebgitted:latest

#logs can be mounted
docker run -d -p 8001:80 --volume /var/git/en.organiknowledge.com/:/var/repository -v /var/log/$MYSITE:/var/log/nginx --name server staticwebgitted:latest


#Take the hand on the server

docker exec -it $CONTAINER_NAME bash


# Make it deploy 
docker exec -it server /root/deploy.sh


Inspirations & Sources
-------

https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile
source container

https://www.digitalocean.com/community/tutorials/how-to-deploy-jekyll-blogs-with-git
Good, but without Nginx nor Docker.. Good if you got 1 website, not if you deploy lots of them on https://www.google.com/search?client=safari&rls=en&q=heterogenous&ie=UTF-8&oe=UTF-8#q=heterogeneous environments

https://docs.docker.com/reference/builder/
https://docs.docker.com/articles/dockerfile_best-practices/
http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
A must read


Todo
--------
Improve log management and infos
=> + a new repo on vizualization

Propose different containers for different  versions of jekyll on different branches ?
=> https://github.com/jekyll/jekyll/issues/2327

Use baseimage-docker ?
=> https://github.com/phusion/baseimage-docker
=> really ? even if https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/ ?

