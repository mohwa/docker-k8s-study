#!/usr/bin/env bash

source $GITHUB_WORKSPACE/scripts/utils.sh

# 실행중인 이전 컨테이너들을 모두 중지한 후, 삭제한다
echo $CLIENT_CONTAINER_NAME
#stop_container $CLIENT_CONTAINER_NAME
#stop_container $BACKEND_CONTAINER_NAME
#stop_container $MYSQL_CONTAINER_NAME
#stop_container $NGINX_CONTAINER_NAME

# workspace root path 로 이동한다.
cd $GITHUB_WORKSPACE

docker-compose -p prod up --force-recreate -d