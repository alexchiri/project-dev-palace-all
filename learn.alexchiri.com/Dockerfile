FROM alexchiri.azurecr.io/k8s-with-docker:1

ENV MAVEN_VERSION="3.6.3"

SHELL ["zsh", "-c"]

USER root

# install JDK 11.0.7
RUN cd /tmp && curl -LO https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.7%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz \
  && tar -xzvf OpenJDK11U-jdk_x64_linux_hotspot_11.0.7_10.tar.gz \
  && mkdir /usr/lib/jvm && sudo mv jdk-11.0.7+10 /usr/lib/jvm/jdk-11.0.7+10
RUN echo "export JAVA_HOME=/usr/lib/jvm/jdk-11.0.7+10" >> /home/alex/.zshrc
RUN sed -i 's~PATH:~PATH:/usr/lib/jvm/jdk-11.0.7+10/bin:~g' /home/alex/.zshrc

# install maven
RUN cd /tmp && curl -o /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz http://apache.mirrors.spacedump.net/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && tar -xzvf /tmp/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt
RUN echo "export M2_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> /home/alex/.zshrc
RUN echo "export MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> /home/alex/.zshrc
RUN sed -i "s~PATH:~PATH:/opt/apache-maven-${MAVEN_VERSION}/bin:~g" /home/alex/.zshrc

USER alex