#!/usr/bin/env bash

function stop_container() {
  local container_name=$1
  local container_id=$(docker ps -q --filter "name=$container_name")

  # container_id 의 길이가 0 이상이면
  if [ -n "$container_id" ]; then
    docker stop $container_name
    docker rm -fv $container_name
  fi

  local result_code=$?

  echo result_code: $result_code
  echo container_id: $container_id

  return $result_code
}

function remove_image() {
  local image_name=$1
  local image_version=$2
  local image_id=$(docker images --filter "before=$image_name" --filter=reference="$image_name:*" -q)

  if [ -n "$image_id" ]; then
    docker rmi -f $image_id
  fi

  local result_code=$?

  echo result_code: $?
  echo image_id: $image_id

  return $result_code
}
