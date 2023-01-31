FROM basic:1

USER root
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install jq unzip python3 apt-transport-https ca-certificates software-properties-common jid fzf

ARG USERNAME=alex
USER ${USERNAME}

ENV KUBECTL_VERSION="v1.26.1"
ENV HELM_VERSION="v3.11.0"
ENV STERN_VERSION="1.23.0"
ENV EKSCTL_VERSION="v0.127.0"
ENV CROSSPLANE_VERSION="v1.10.2"

USER root

# install kubectl
RUN cd /tmp && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# install helm
RUN cd /tmp && curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzvf ./helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && chmod +x ./linux-amd64/helm \
    && mv ./linux-amd64/helm /usr/local/bin/helm

# install eksctl
RUN cd /tmp && curl -LO https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_amd64.tar.gz \
    && tar -xzvf ./eksctl_Linux_amd64.tar.gz \
    && chmod +x ./eksctl \
    && mv ./eksctl /usr/local/bin/eksctl

# install kubens and kubectx
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx
RUN ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
RUN ln -s /opt/kubectx/kubens /usr/local/bin/kubens
RUN mkdir -p /home/${USERNAME}/.oh-my-zsh/completions
RUN chmod -R 755 /home/${USERNAME}/.oh-my-zsh/completions
RUN ln -s /opt/kubectx/completion/kubectx.zsh /home/${USERNAME}/.oh-my-zsh/completions/_kubectx.zsh
RUN ln -s /opt/kubectx/completion/kubens.zsh /home/${USERNAME}/.oh-my-zsh/completions/_kubens.zsh

# install stern
RUN cd /tmp && curl -LO https://github.com/stern/stern/releases/download/v${STERN_VERSION}/stern_${STERN_VERSION}_linux_amd64.tar.gz \
    && tar -xzvf stern_${STERN_VERSION}_linux_amd64.tar.gz \
    && chmod +x ./stern \
    && mv ./stern /usr/local/bin/stern

# install crossplane
RUN curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | XP_CHANNEL=stable XP_VERSION=${CROSSPLANE_VERSION} sh

USER ${USERNAME}

# add kubectl autocomplete with alias
RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc
RUN echo "alias k=kubectl" >> ~/.zshrc
RUN echo "complete -F __start_kubectl k" >> ~/.zshrc
