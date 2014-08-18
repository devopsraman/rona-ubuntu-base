FROM ubuntu:14.04

MAINTAINER Ronan Gill <ronan.gill@vodafone.com>

ADD sources.list /etc/apt/sources.list
  
RUN apt-get update
RUN apt-get -y dist-upgrade

RUN locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8
ENV HOME /root

RUN apt-get -y install vim curl wget supervisor 
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d

# supervisor base configuration
ADD supervisord.conf /etc/supervisor/supervisord.conf

# default command
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
