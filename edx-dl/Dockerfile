FROM basic:1

USER root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev unzip

RUN cd /tmp && curl -LO https://www.python.org/ftp/python/3.6.10/Python-3.6.10.tgz \
    && tar -xzvf ./Python-3.6.10.tgz \
    && cd Python-3.6.10 \
    && ./configure --enable-optimizations \
    && make altinstall

RUN cd /home/alex && curl -LO https://github.com/neuronalism/edxdlr/archive/refs/heads/master.zip \
    && unzip ./master.zip \
    && cd edxdlr-master \
    && pip3.6 install -r requirements.txt

