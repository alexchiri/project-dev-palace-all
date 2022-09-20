FROM remix:1

USER root

RUN apt-get update && apt-get install -y unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

ENV PULUMI_VERSION="v3.32.1"
ENV KUBECTL_VERSION="v1.23.6"
ENV AWS_AUTH_VERSION="1.21.2"
ENV DENO_VERSION="v1.25.3"

RUN cd /tmp && curl -LO https://get.pulumi.com/releases/sdk/pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && tar -xzvf ./pulumi-${PULUMI_VERSION}-linux-x64.tar.gz \
    && chmod +x ./pulumi/pulumi \
    && mv ./pulumi/pulumi /usr/local/bin/pulumi \
    && chmod +x ./pulumi/pulumi-language-nodejs \
    && mv ./pulumi/pulumi-language-nodejs /usr/local/bin/pulumi-language-nodejs

# install kubectl
RUN cd /tmp && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# install aws-iam-authenticator
RUN cd /tmp && curl -o aws-iam-authenticator https://s3.us-west-2.amazonaws.com/amazon-eks/${AWS_AUTH_VERSION}/2021-07-05/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x aws-iam-authenticator \
    && mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# install deno
RUN cd /tmp && curl -LO https://github.com/denoland/deno/releases/download/${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
    && unzip ./deno-x86_64-unknown-linux-gnu.zip \
    && chmod +x ./deno \
    && mv deno /usr/local/bin