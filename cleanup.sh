#!/usr/bin/env bash

function remove_image() {
  local image_name=$1
  local image_id=$(docker images --filter "before=$image_name:$IMAGE_VERSION" --filter=reference="$image_name:*" -q)

  if [ -n "$image_id" ]; then
    docker rmi -f $image_id
  fi

  local result_code=$?

  echo ret_code: $?
  echo image_id: $image_id

  return $result_code
}

remove_image($CLIENT_CONTAINER_NAME)
remove_image($BACKEND_CONTAINER_NAME)
remove_image($MYSQL_CONTAINER_NAME)
remove_image($NGINX_CONTAINER_NAME)
