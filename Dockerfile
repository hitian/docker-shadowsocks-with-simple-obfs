# shadowsocks
#
# VERSION 0.0.3

#For amd64
FROM ubuntu:latest
#For Raspberry Pi armhf
#FROM armhf/ubuntu:latest

MAINTAINER  jia <jia.tian@me.com>

ENV VERSION v3.0.4
ENV DEPENDENCIES libtool libpcre3-dev libev-dev libudns-dev ca-certificates
ENV BUILD_DEPENDENCIES gettext build-essential autoconf asciidoc xmlto automake git curl
ENV LIBSODIUM_VER 1.0.11
ENV MBEDTLS_VER 2.4.0

#For amd64
#RUN sed -i -- 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
#For Raspberry Pi armhf
#RUN sed -i -- 's/ports.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends $DEPENDENCIES $BUILD_DEPENDENCIES

RUN curl -o /tmp/libsodium-$LIBSODIUM_VER.tar.gz https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz && \
    tar xvf /tmp/libsodium-$LIBSODIUM_VER.tar.gz -C /tmp && \
    cd /tmp/libsodium-$LIBSODIUM_VER && \
    ./configure --prefix=/usr && make -j4 && make install && \
    curl -o /tmp/mbedtls-$MBEDTLS_VER-gpl.tgz https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz && \
    tar xvf /tmp/mbedtls-$MBEDTLS_VER-gpl.tgz -C /tmp && \
    cd /tmp/mbedtls-$MBEDTLS_VER && make -j4 && make install && \
    rm -rf /tmp/libsodium* /tmp/mbedtls*

# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git  /tmp/shadowsocks-libev && \
    cd /tmp/shadowsocks-libev && git submodule update --init --recursive && \
    ./autogen.sh && ./configure --with-sodium=/usr && make -j4 && \
    make install && \
    git clone https://github.com/shadowsocks/simple-obfs.git /tmp/simple-obfs && \
    cd /tmp/simple-obfs && git submodule update --init --recursive && ./autogen.sh && \
    ./configure && make -j4 && make install && \
    rm -rf /tmp/shadowsocks-libev /tmp/simple-obfs

RUN apt-get remove -y $BUILD_DEPENDENCIES && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

VOLUME ["/config/"]
CMD ["ss-server", "-h"]