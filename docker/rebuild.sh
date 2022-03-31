#!/usr/bin/env zsh

[ -f docker.tar ] && rm -f *.tar
docker build -t alexchiri.azurecr.io/docker:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/docker:latest" | awk '{ print $1 }')
docker container export -o docker.tar $(docker create alexchiri.azurecr.io/docker:latest)