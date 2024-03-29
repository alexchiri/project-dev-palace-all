FROM docker:1

USER root
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install jq unzip python3 apt-transport-https \
    ca-certificates software-properties-common jid conntrack

# fix for issue with running kind in WSL2 and with Docker CE, but this cannot be run here, because these exist at this point.
# need to look further into this, for now I am just running these manually every time I get the issue with kind - should probably make a script
# https://github.com/microsoft/WSL/issues/4189
# https://github.com/docker/for-linux/issues/219
# Also, there is another way to do this here, but it doesn't really work: https://kind.sigs.k8s.io/docs/user/using-wsl2/#cannot-find-cgroup-mount-destination-unknown
#RUN mkdir /sys/fs/cgroup/systemd
#RUN mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

USER alex

ENV KUBECTL_VERSION="v1.28.7"
ENV HELM_VERSION="v3.14.2"
ENV STERN_VERSION="1.28.0"
ENV MINIKUBE_VERSION="v1.32.0"
ENV ARGOCDCLI_VERSION="v2.10.1"

# USER root

# include script to bring to fix docker issue (and make sure it has linux style line endings)
# COPY start_docker /usr/local/sbin/start_docker
# RUN chmod +x /usr/local/sbin/start_docker
# RUN dos2unix /usr/local/sbin/start_docker

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
RUN mkdir -p /home/alex/.oh-my-zsh/completions
RUN chmod -R 755 /home/alex/.oh-my-zsh/completions
RUN ln -s /opt/kubectx/completion/_kubectx.zsh /home/alex/.oh-my-zsh/completions/kubectx.zsh
RUN ln -s /opt/kubectx/completion/_kubens.zsh /home/alex/.oh-my-zsh/completions/kubens.zsh

# install argocd
RUN cd /tmp && \
    curl -LO https://github.com/argoproj/argo-cd/releases/download/v2.10.1/argocd-linux-amd64 && \
    install argocd-linux-amd64 /usr/local/bin/minikube

USER alex

# add kubectl autocomplete with alias
RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc
RUN echo "alias k=kubectl" >> ~/.zshrc
RUN echo "complete -F __start_kubectl k" >> ~/.zshrc