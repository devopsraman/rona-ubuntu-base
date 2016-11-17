FROM ubuntu:16.10

MAINTAINER Ronan Gill <ronan@gillsoft.org>

ENV DISTRIB_CODENAME yakkety

ADD sources.list /etc/apt/sources.list

RUN sed -i 's/##release##/'$DISTRIB_CODENAME'/' /etc/apt/sources.list && \
	apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq netcat iproute2 && \
    apt-get -yq dist-upgrade && DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq net-tools vim-tiny curl wget software-properties-common git htop unzip && \
    apt-get clean && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo Europe/London > /etc/timezone && \
    dpkg-reconfigure tzdata && \
    locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG

RUN usermod -u 1034 www-data

ADD 00proxy /etc/apt/apt.conf.d/00proxy
ADD detect-apt-proxy /etc/apt/detect-apt-proxy
ADD aliases.sh /etc/profile.d/aliases.sh
ADD functions.sh /etc/profile.d/functions.sh

RUN chmod a+x /etc/profile.d/*.sh

CMD /bin/bash -l
