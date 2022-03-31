#!/usr/bin/env zsh

az acr repository delete -y -n alexchiri --repository basic
az acr repository delete -y -n alexchiri --repository k8s
az acr repository delete -y -n alexchiri --repository azure