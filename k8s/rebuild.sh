#!/usr/bin/env zsh

[ -f k8s.tar ] && rm -f *.tar
docker build -t alexchiri.azurecr.io/k8s:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/k8s:latest" | awk '{ print $1 }')
docker container export -o k8s.tar $(docker create alexchiri.azurecr.io/k8s:latest)