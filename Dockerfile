FROM arm64v8/ubuntu:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="unifi:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="jdfalk"

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
RUN \
    echo "**** install packages ****" && \
    apt-get update && \
    apt-get -y install \
    curl \
    binutils \
    jsvc \
    libcap2 \
    mongodb-server \
    monit \
    openjdk-8-jre-headless \
    pcregrep && \
    apt-get clean -y && \
    cd /root && \
    curl -o /root/unifi_sysvinit_all.deb -s -L https://dl.ui.com/unifi/5.12.22/unifi_sysvinit_all.deb && \
    dpkg -i /root/unifi_sysvinit_all.deb && \
    sed -i '/SYSLOG/d' /etc/init.d/unifi

COPY monit-mongodb /etc/monit/conf.d/monit-mongodb