FROM k8s:1

ARG USERNAME=alex

USER root

ENV TERRAFORM_VERSION="0.12.29"

RUN cd /tmp && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && chmod +x ./terraform \
    && mv ./terraform /usr/local/bin/terraform

