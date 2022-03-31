#!/usr/bin/env zsh

[ -f basic.tar ] && rm -f *.tar
docker build --build-arg WSL_USER_PASS=$WSL_USER_PASS -t alexchiri.azurecr.io/basic:latest .
docker container rm $(docker ps -a | grep "alexchiri.azurecr.io/basic:latest" | awk '{ print $1 }')
docker container export -o basic.tar $(docker create alexchiri.azurecr.io/basic:latest)