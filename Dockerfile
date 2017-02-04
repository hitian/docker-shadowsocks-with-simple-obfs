# shadowsocks
#
# VERSION 0.0.3

#For amd64
FROM ubuntu:latest
#For Raspberry Pi armhf
#FROM armhf/ubuntu:latest

MAINTAINER  jia <jia.tian@me.com>

ENV BASEDIR /tmp/shadowsocks-libev
ENV DEPENDENCIES gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libudns-dev automake

#For amd64
#RUN sed -i -- 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
#For Raspberry Pi armhf
#RUN sed -i -- 's/ports.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y git wget
RUN apt-get install -y --no-install-recommends $DEPENDENCIES
ADD install_deps.sh /
WORKDIR /tmp
RUN sh /install_deps.sh

#shadowsocks VERSION v3.0.0
# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git  $BASEDIR
WORKDIR $BASEDIR
RUN git submodule update --init --recursive \
 && ./autogen.sh \
 && ./configure --with-sodium=/usr \
 && make \
 && make install
#install simple-obfs
RUN git clone https://github.com/shadowsocks/simple-obfs.git /tmp/simple-obfs
WORKDIR /tmp/simple-obfs
RUN git submodule update --init --recursive \
 && ./autogen.sh \
 && ./configure && make \
 && make install

VOLUME ["/config/"]

# Tear down building environment and delete git repository
WORKDIR /
RUN rm -rf /tmp/* 

#ENTRYPOINT ["ss-local", "-u"]
#CMD ["-c", "/config/client.json"]