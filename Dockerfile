FROM docker.gillsoft.org/ubuntu:15.04

MAINTAINER Ronan Gill <ronan@gillsoft.org>

ADD 00proxy /etc/apt/apt.conf.d/00proxy
ADD detect-apt-proxy /etc/apt/detect-apt-proxy

RUN apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get install -yq vim-tiny curl wget software-properties-common git htop man unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo Europe/London > /etc/timezone && \
    dpkg-reconfigure tzdata && \
    locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG

RUN usermod -u 1034 www-data

CMD /bin/bash
