#!/usr/bin/env zsh

az acr login -n $ACR_NAME

cd basic && ./rebuild.sh && cd ..
cd docker && ./rebuild.sh && cd ..
cd k8s && ./rebuild.sh && cd ..
cd azure && ./rebuild.sh && cd ..
cd k8s-with-docker && ./rebuild.sh && cd ..
cd learn.alexchiri.com && ./rebuild.sh && cd ..