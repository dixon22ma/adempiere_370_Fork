FROM ubuntu:14.04

MAINTAINER Dixon Martinez "https://github.com/dixon22ma"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget gzip tar
RUN apt-get clean

RUN mkdir /opt/Install/ \ && cd /opt/Install
RUN wget http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar xvzf jdk-7u79-linux-x64.tar.gz -C /usr/local/jdk

RUN update-alternatives --install /usr/bin/java java /usr/local/jdk/bin/java 1067
RUN update-alternatives --install /usr/bin/javac javac /usr/local/jdk/bin/javac 1067
RUN update-alternatives --install /usr/bin/javaws javaws /usr/local/jdk/bin/javaws 1067



RUN update-alternatives --auto java
RUN update-alternatives --auto javac
RUN update-alternatives --auto javaws

RUN java -version

EXPOSE 8080
