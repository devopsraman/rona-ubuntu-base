FROM ubuntu:14.04

MAINTAINER Ronan Gill <ronan.gill@vodafone.com>

ENV DEBIAN_FRONTEND noninteractive

ADD sources.list /etc/apt/sources.list
ADD 00proxy /etc/apt/apt.conf.d/00proxy

RUN echo Europe/London > /etc/timezone && dpkg-reconfigure tzdata
  
RUN apt-get update && apt-get -yq dist-upgrade

RUN locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8
ENV HOME /root

RUN apt-get install -yq software-properties-common python-software-properties vim-tiny curl wget supervisor sysvbanner
RUN mkdir -p /var/log/supervisor && mkdir -p /etc/supervisor/conf.d

# supervisor base configuration
ADD supervisord.conf /etc/supervisor/supervisord.conf

RUN usermod -u 1034 www-data && \
    groupmod -g 1034 www-data && \
    usermod -g users www-data

# default command
CMD COLUMNS=160 banner  $(hostname -I); \
    echo "$(hostname) : $(hostname -I)"; \
    supervisord -c /etc/supervisor/supervisord.conf

# clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
