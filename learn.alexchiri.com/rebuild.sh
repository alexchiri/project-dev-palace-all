#!/usr/bin/env zsh

[ -f learn.tar ] && rm -f *.tar
docker build -t alexchiri.azurecr.io/learn:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/learn:latest" | awk '{ print $1 }')
docker container export -o learn.tar $(docker create alexchiri.azurecr.io/learn:latest)