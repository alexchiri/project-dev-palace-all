FROM ubuntu:22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get -y install zsh curl git sudo locales vim dos2unix wget \
    iputils-ping iproute2 jq apt-transport-https

# disable annoying warning introduced in sudo: https://github.com/sudo-project/sudo/issues/42
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

# create user and set password
ARG USERNAME=alex
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt-get update \
    && apt-get install -y sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

COPY wsl.conf /etc/wsl.conf

# generate locale so the agnoster zsh theme works
RUN locale-gen en_US.UTF-8

USER ${USERNAME}

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# configure git
ARG GIT_EMAIL
ARG GIT_NAME
RUN git config --global user.email ${GIT_EMAIL}
RUN git config --global user.name ${GIT_NAME}
RUN git config --global core.autocrlf false

# change the shade of blue in the theme
RUN sed -i '0,/blue/{s/blue/39d/}' /home/${USERNAME}/.oh-my-zsh/themes/agnoster.zsh-theme

USER root
# copy zsh config
COPY .zshrc /home/${USERNAME}/.zshrc
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.zshrc
RUN dos2unix /home/${USERNAME}/.zshrc
RUN usermod --shell /usr/bin/zsh ${USERNAME}

# copy vim config
COPY .vimrc /home/${USERNAME}/.vimrc
RUN dos2unix /home/${USERNAME}/.vimrc
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.vimrc