#!/usr/bin/env bash

function stop_container() {
  local container_name=$1
  local container_id=$(docker ps -q --filter "name=$container_name")

  if [ -n "$container_id" ]; then
    docker stop $container_name
    docker rm -fv $container_name
  fi

  local result_code=$?

  echo result_code: $result_code
  echo container_id: $container_id

  return $result_code
}

stop_container $CLIENT_CONTAINER_NAME
stop_container $BACKEND_CONTAINER_NAME
stop_container $MYSQL_CONTAINER_NAME
stop_container $NGINX_CONTAINER_NAME

echo $GITHUB_WORKSPACE

cd $GITHUB_WORKSPACE

docker-compose up -d