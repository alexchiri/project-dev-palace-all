FROM basic:1

USER root

RUN mkdir -p /etc/apt/keyrings && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb jammy main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt update && apt install -y temurin-17-jdk

ENV MAVEN_VERSION="3.9.0"

USER root

RUN echo "export JAVA_HOME=/usr/lib/jvm/temurin-17-jdk-arm64" >> /home/alex/.zshrc
RUN echo "export PATH=\$PATH:/usr/lib/jvm/temurin-17-jdk-arm64/bin" >> /home/alex/.zshrc

# install maven
RUN cd /opt && curl -LO https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzvf ./apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && chmod +x ./apache-maven-${MAVEN_VERSION}/bin/mvn

RUN echo "export M2_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> /home/alex/.zshrc
RUN echo "export MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> /home/alex/.zshrc
RUN sed -i "s~PATH:~PATH:/opt/apache-maven-${MAVEN_VERSION}/bin:~g" /home/alex/.zshrc


