FROM ubuntu:16.04

MAINTAINER Ronan Gill <ronan@gillsoft.org>

ENV DISTRIB_CODENAME xenial

ADD 00proxy /etc/apt/apt.conf.d/00proxy
ADD detect-apt-proxy /etc/apt/detect-apt-proxy
ADD sources.list /etc/apt/sources.list

RUN sed -i 's/##release##/'$DISTRIB_CODENAME'/' /etc/apt/sources.list && \
	apt-get update && \
    apt-get install -yq netcat iproute2 && \
    apt-get -yq dist-upgrade && \
    apt-get install -yq netcat vim-tiny curl wget software-properties-common git htop man unzip && \
    apt-get clean && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo Europe/London > /etc/timezone && \
    dpkg-reconfigure tzdata && \
    locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG
ENV DISTRIB_CODENAME wily

RUN usermod -u 1034 www-data

CMD /bin/bash
