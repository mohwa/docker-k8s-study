#!/bin/bash


images=($(docker images --format  "{{.ID}}"))

docker rmi -f $image_id

echo completed delete images

