FROM --platform=linux/amd64 basic:1

USER root

RUN apt-get update && apt-get -y install unzip

ENV SLACK_CLI_VERSION="2.3.0"

RUN cd /tmp && curl -LO https://downloads.slack-edge.com/slack-cli/slack_cli_${SLACK_CLI_VERSION}_linux_64-bit.tar.gz \
    && tar -xzvf ./slack_cli_${SLACK_CLI_VERSION}_linux_64-bit.tar.gz \
    && chmod +x ./bin/slack \
    && mv ./bin/slack /usr/local/bin/slack

USER alex

ENV DENO_VERSION="v1.34.1"
RUN curl -fsSL https://deno.land/install.sh | sh -s ${DENO_VERSION}

RUN echo "export DENO_INSTALL=\"/home/alex/.deno\"" >> /home/alex/.zshrc
RUN echo "export PATH=\"\$DENO_INSTALL/bin:\$PATH\"" >> /home/alex/.zshrc

