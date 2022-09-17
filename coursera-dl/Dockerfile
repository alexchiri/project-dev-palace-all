FROM basic:1

USER root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get -y install python3.9 python3-pip

RUN python3 -m pip install coursera-dl==0.11.5
