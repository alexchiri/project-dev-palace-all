FROM ubuntu:22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install zsh curl git sudo locales vim dos2unix wget \
    iputils-ping iproute2 jq apt-transport-https \
    jid ca-certificates gnupg-agent software-properties-common \
    unzip python3 conntrack    

# create user and set password
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt-get update \
    && apt-get install -y sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

USER root

COPY wsl.conf /etc/wsl.conf
RUN dos2unix /etc/wsl.conf

# generate locale so the agnoster zsh theme works
RUN locale-gen en_US.UTF-8

# install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

RUN usermod -aG docker ${USERNAME}
RUN newgrp docker

# K8s specific tools
ENV KUBECTL_VERSION="v1.28.7"
ENV HELM_VERSION="v3.14.2"
ENV STERN_VERSION="1.28.0"
ENV MINIKUBE_VERSION="v1.32.0"
ENV ARGOCDCLI_VERSION="v2.10.1"

# install kubectl
RUN cd /tmp && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# install helm
RUN cd /tmp && curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzvf ./helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && chmod +x ./linux-amd64/helm \
    && mv ./linux-amd64/helm /usr/local/bin/helm

# install stern
RUN cd /tmp && curl -LO https://github.com/stern/stern/releases/download/v${STERN_VERSION}/stern_${STERN_VERSION}_linux_amd64.tar.gz \
    && tar -xzvf stern_${STERN_VERSION}_linux_amd64.tar.gz \
    && chmod +x ./stern \
    && mv ./stern /usr/local/bin/stern

# install minikube
RUN cd /tmp && \
    curl -LO https://github.com/kubernetes/minikube/releases/download/${MINIKUBE_VERSION}/minikube-linux-amd64 && \
    install minikube-linux-amd64 /usr/local/bin/minikube

# install kubens and kubectx
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx
RUN ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
RUN ln -s /opt/kubectx/kubens /usr/local/bin/kubens
RUN mkdir -p /home/${USERNAME}/.oh-my-zsh/completions
RUN chmod -R 755 /home/${USERNAME}/.oh-my-zsh/completions
RUN ln -s /opt/kubectx/completion/_kubectx.zsh /home/${USERNAME}/.oh-my-zsh/completions/kubectx.zsh
RUN ln -s /opt/kubectx/completion/_kubens.zsh /home/${USERNAME}/.oh-my-zsh/completions/kubens.zsh

# install argocd
RUN cd /tmp && \
    curl -LO https://github.com/argoproj/argo-cd/releases/download/v2.10.1/argocd-linux-amd64 && \
    install argocd-linux-amd64 /usr/local/bin/argocd

USER ${USERNAME}

# change the shade of blue in the theme
RUN sed -i '0,/blue/{s/blue/39d/}' /home/${USERNAME}/.oh-my-zsh/themes/agnoster.zsh-theme

# configure git
ARG GIT_EMAIL
ARG GIT_NAME
RUN git config --global user.email ${GIT_EMAIL}
RUN git config --global user.name ${GIT_NAME}
RUN git config --global core.autocrlf false

USER root

# copy zsh config
COPY .zshrc /home/${USERNAME}/.zshrc
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.zshrc
RUN dos2unix /home/${USERNAME}/.zshrc
RUN usermod --shell /usr/bin/zsh ${USERNAME}

# add kubectl autocomplete with alias
RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc
RUN echo "alias k=kubectl" >> ~/.zshrc
RUN echo "complete -F __start_kubectl k" >> ~/.zshrc

# copy script to copy SSH key
COPY bring_ssh_files_from_windows /home/ubuntu/bring_ssh_files_from_windows
RUN dos2unix /home/ubuntu/bring_ssh_files_from_windows
RUN chown ubuntu:ubuntu /home/ubuntu/bring_ssh_files_from_windows && chmod +x /home/ubuntu/bring_ssh_files_from_windows