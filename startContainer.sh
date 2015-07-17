#!/bin/bash


USAGE="Usage: $0 repo_path container_name [port]"


if [ "$#" -lt "2" ]; then
	echo "$USAGE"
	exit 1
fi

GIT_REPO=$1
CONTAINER_NAME=$2
CONTAINER_PORT=$3

echo -n "Determining port mapping configuration ..."

if
  [ -n "${CONTAINER_PORT}" ]
then
  PORT_CONFIG="-p $CONTAINER_PORT:80"
  echo " map to $CONTAINER_PORT"
else
  PORT_CONFIG="-P"
  echo " map to random port"
fi


echo  "Starting container $CONTAINER_NAME ..."

echo "Port config : $PORT"

#   -p $CONTAINER_PORT:80 \
docker run -d \
   $PORT_CONFIG \
   -v $GIT_REPO:/var/repository \
   -v /var/log/$CONTAINER_NAME:/var/log/nginx \
   --name $CONTAINER_NAME \
   camillevau/gitjekyllnginx:latest &&  echo " done" ||  exit 1


echo -n "Copying git repository hook ..."

cat post-receive>$1/hooks/post-receive && echo " done" || exit 1

echo -n "Configuring git repository hook ..."

sed -i -e "s/CONTAINER_NAME=webserver/CONTAINER_NAME=${CONTAINER_NAME}/g" $1/hooks/post-receive && echo " done" || exit 1;

echo -n "Setting repository hook executable ..."

chmod u+x $GIT_REPO/hooks/post-receive  && echo " done" || exit 1


docker exec $CONTAINER_NAME /root/deploy.sh && echo "All right, we've done great business here !"
