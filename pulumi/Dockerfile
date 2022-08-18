FROM remix:1

USER root

RUN apt-get update && apt-get -y install unzip

ENV PULUMI_VERSION="v3.35.3"

# install aws CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# install pulumi
RUN cd /tmp && curl -LO https://get.pulumi.com/releases/sdk/pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && tar -xzvf ./pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && chmod +x ./pulumi/pulumi \
    && mv ./pulumi/pulumi /usr/local/bin/pulumi \
    && chmod +x ./pulumi/pulumi-language-nodejs \
    && mv ./pulumi/pulumi-language-nodejs /usr/local/bin/pulumi-language-nodejs