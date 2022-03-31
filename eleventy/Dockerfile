FROM basic:1

USER root

ENV NODE_VERSION="12"
ENV ELEVENTY_VERSION="0.12.1"

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
RUN apt-get update && apt install -y nodejs build-essential
RUN npm install -g "@11ty/eleventy@${ELEVENTY_VERSION}"
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && sudo apt install yarn
