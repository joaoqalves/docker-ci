#
# Java 7, Maven 3, Solr 4.10 and MongoDB 2.6 Dockerfile
#
# https://github.com/joaoqalves/docker-ci
# Based on https://github.com/jamesdbloom/docker_java7_maven
#

# pull base image.
FROM debian:wheezy

MAINTAINER João Alves "joaoqalves@gmail.com"

RUN  \
  export DEBIAN_FRONTEND=noninteractive && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y python-software-properties debconf-utils && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  apt-get install -y adduser curl oracle-java7-installer maven mongodb-org && \
  curl -O http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz && \
  tar -zxvf solr-4.10.4.tgz && mv solr-4.10.4 solr && cp -R solr/example/* solr/ && mv solr/solr solr/solr_data && \
  rm -rf solr/solr_data/collection1 && \
  service mongod start


CMD ["/bin/bash"]
