#!/usr/bin/env bash

source $GITHUB_WORKSPACE/scripts/utils.sh

stop_container $CLIENT_CONTAINER_NAME
stop_container $BACKEND_CONTAINER_NAME
stop_container $MYSQL_CONTAINER_NAME
stop_container $NGINX_CONTAINER_NAME

# workspace root path 로 이동한다.
cd $GITHUB_WORKSPACE

docker-compose up --force-recreate -d