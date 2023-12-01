FROM --platform=linux/amd64 basic:1

RUN apt-get update && apt-get -y install unzip

ARG USERNAME=alex

USER root

ENV TERRAFORM_VERSION="1.6.2"

RUN cd /tmp && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && chmod +x ./terraform \
    && mv ./terraform /usr/local/bin/terraform

