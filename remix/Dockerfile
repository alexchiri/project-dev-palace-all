FROM basic:1

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt update

RUN apt install -y nodejs
RUN apt install -y --no-install-recommends yarn
