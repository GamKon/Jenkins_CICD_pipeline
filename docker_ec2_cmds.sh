#!/usr/bin/env bash
export IMAGE=$1
export DOCKER_USER=$2
export DOCKER_PWD=$3
echo $DOCKER_PWD | docker login -u $DOCKER_USER --password-stdin
# Stop and remove all old containers
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
# Pull and start new app container
docker run -p 8080:8080 -d $IMAGE
# Use in casse of a multicontainer app
#docker-compose -f docker-compose.yml up --detach
echo "success"