FROM arm64v8/openjdk:11-jre

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
    apt-get -y install binutils pcregrep mongodb-server openjdk-8-jre-headless jsvc && \
    curl -o /root/unify.deb -L https://dl.ui.com/unifi/5.12.22/unifi_sysvinit_all.deb && \
    dpkg -i /root/unify.deb && \
    apt-get clean -y