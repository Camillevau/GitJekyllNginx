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
export CONTAINER_PORT=8080
````

### Git repository set-up

````
git init --bare $GIT_REPO
````

### init docker repo

````
./startContainer.sh $GIT_REPO $CONTAINER_NAME $CONTAINER_PORT
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

### Push your jekyll web site into your bare repo


git push user@server:$GIT_REPO [branch]


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
