#!/usr/bin/env zsh

[ -f azure.tar ] && rm -f *.tar
docker build -t alexchiri.azurecr.io/azure:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/azure:latest" | awk '{ print $1 }')
docker container export -o azure.tar $(docker create alexchiri.azurecr.io/azure:latest)