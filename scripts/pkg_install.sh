#!/usr/bin/env bash

# install util packages
yum install epel-release -y
yum install vim-enhanced -y
yum install git -y

# install docker
yum install yum-utils -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce

systemctl start docker
