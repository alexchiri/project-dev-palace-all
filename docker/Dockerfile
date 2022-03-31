FROM alexchiri.azurecr.io/basic:1

USER root
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install jq jid apt-transport-https ca-certificates gnupg-agent software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

RUN service docker start
# Docker service doesn't seem to start automatically, might have to do more here

RUN usermod -aG docker alex
RUN newgrp docker