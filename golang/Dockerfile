FROM --platform=linux/amd64 basic:1

USER alex

ENV GO_VERSION="1.17.13"
ENV GO111MODULE="on"

USER root

RUN apt-get update && apt-get install -y build-essential

# install go
RUN cd /tmp && curl -LO "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" \
  && tar -xvzf "./go${GO_VERSION}.linux-amd64.tar.gz" -C /usr/local \
  && echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/alex/.zshrc

USER alex 

RUN sed -i 's~PATH:~PATH:/home/alex/go/bin:~g' ~/.zshrc