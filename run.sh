#!/bin/bash

set -ex

# REMOVE last deploy
container_id=`docker ps | grep file | awk -F " " '{print $1}'`
if [ -n "$container_id" ]; then
  docker stop $container_id
  docker rm $container_id
fi

# START new deploy
go build ./file_server.go
docker build --rm -t file_server .
docker tag file_server registry.cn-beijing.aliyuncs.com/shannonai/file_server:v1.0.0
docker-compose up -d
container_id=`docker ps | grep file | awk -F " " '{print $1}'`
echo "container_id: $container_id"
docker exec -it $container_id bash
