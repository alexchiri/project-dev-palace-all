FROM k8s:1

USER root

RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt update && apt install -y mongodb-org-shell unzip

RUN cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

ENV PULUMI_VERSION="v3.32.1"

RUN cd /tmp && curl -LO https://get.pulumi.com/releases/sdk/pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && tar -xzvf ./pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && chmod +x ./pulumi/pulumi \
    && mv ./pulumi/pulumi /usr/local/bin/pulumi \
    && chmod +x ./pulumi/pulumi-language-nodejs \
    && mv ./pulumi/pulumi-language-nodejs /usr/local/bin/pulumi-language-nodejs