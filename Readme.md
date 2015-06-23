#GitJekyllNginx

This is a solution to rapidly deploy a static website with git, [Jekyll][2], [Nginx][3] and [Docker][4]

## How to use
###What you need

 * A local gitted Jekyll website
 * A remote server with ssh, git and docker installed

### Setup variables
some variable are necessary to commands or config files

````
export CONTAINER_NAME=webserver
export GIT_REPO=/var/git/my_repo/
export URL=www.mywebsite.com
#optional
export CONTAINER_PORT=
````

### Git repository set-up

 * Init a git bare repository

````
git init --bare $GIT_REPO
````

 *  add the following hook in hooks/post-receive :

````
#!/bin/bash
CONTAINER_NAME=webserver
echo "Received a commit on the acc server"
docker exec $CONTAINER_NAME /root/deploy.sh > /dev/null && echo "Website updated !"
````

 * DO NOT FORGET
	
````
chmod u+x $GIT_REPO/hooks/post-receive
````

### Run the container

````
docker run -d \
   `[ -z "$CONTAINER_PORT" ] && echo "-p $CONTAINER_PORT:80"` \
   `[ -n "$CONTAINER_PORT" ] && echo "-P"` \
   -v $GIT_REPO:/var/repository \
   -v /var/log/$CONTAINER_NAME:/var/log/nginx \
   --name $CONTAINER_NAME \
   camillevau/gitjekyllnginx:latest
````

### Configure your host proxy

* for an nginx webserver

````
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
````



##Docker tricks

###How to build the image

````
docker build -t gitjekyllnginx .
````

###Take the hand on the server

````
docker exec -it $CONTAINER_NAME bash
````


##More

###Inspirations & Sources

https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile
source CONTAINER_NAME

https://www.digitalocean.com/community/tutorials/how-to-deploy-jekyll-blogs-with-git
Good, but without Nginx nor Docker.

https://www.google.com/search?client=safari&rls=en&q=heterogenous&ie=UTF-8&oe=UTF-8#q=heterogeneous environments

https://docs.docker.com/reference/builder/
https://docs.docker.com/articles/dockerfile_best-practices/
http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
A must read


###Todo

Add unit testing with Travis

Improve log management and infos

Propose different CONTAINER_NAMEs for different  versions of jekyll on different branches ?
=> https://github.com/jekyll/jekyll/issues/2327

Use baseimage-docker ?
=> https://github.com/phusion/baseimage-docker
=> really ? even if https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/ ?

## License

This application is distributed under the [Apache License, Version 2.0][1].

[1]: http://www.apache.org/licenses/LICENSE-2.0
[2]: http://jekyllrb.com
[3]: http://nginx.com
[4]: http://docker.com
