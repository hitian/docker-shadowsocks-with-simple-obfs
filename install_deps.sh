#!/bin/
export LIBSODIUM_VER=1.0.11
export MBEDTLS_VER=2.4.0
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
cd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make && make install
cd ..
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
cd mbedtls-$MBEDTLS_VER
make && make install

