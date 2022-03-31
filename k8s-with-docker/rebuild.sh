#!/usr/bin/env zsh

[ -f k8s-with-docker.tar ] && rm -f *.tar
docker build -t alexchiri.azurecr.io/k8s-with-docker:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/k8s-with-docker:latest" | awk '{ print $1 }')
docker container export -o k8s-with-docker.tar $(docker create alexchiri.azurecr.io/k8s-with-docker:latest)