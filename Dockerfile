FROM ubuntu:17.04

MAINTAINER Ronan Gill <ronan@gillsoft.org>

ENV DISTRIB_CODENAME zesty

ADD sources.list /etc/apt/sources.list

RUN sed -i 's/##release##/'$DISTRIB_CODENAME'/' /etc/apt/sources.list && \
	  apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get -yq install --no-install-recommends \
          build-essential \
          curl \
          git \
          locales \
          net-tools  \
          software-properties-common \
          tzdata \
          unzip \
          vim-tiny \
          wget && \
    apt-get clean && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo "Europe/London" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE $LANG
ENV LC_ALL $LANG

RUN usermod -u 1034 www-data

CMD /bin/bash
