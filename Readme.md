CONTAINER_NAME=server
MYSITE=en.organiknowledge.com

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
