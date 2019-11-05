FROM arm64v8/ubuntu:bionic

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
    binutils \
    jsvc \
    libcap2 \
    mongodb-server \
    openjdk-8-jre-headless \
    pcregrep && \
    apt-get clean -y && \
    cd /root && \
    wget https://dl.ui.com/unifi/5.12.22/unifi_sysvinit_all.deb && \
    dpkg -i /root/unifi_sysvinit_all.deb