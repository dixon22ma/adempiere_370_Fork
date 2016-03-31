# Creating Docker Image
FROM ubuntu
MAINTAINER Dixon Martinez <dmartinez@erpcya.com>

#Update Packages
RUN apt-get update
RUN apt-get --force-yes install -y wget
RUN apt-get --force-yes install -y openssh-server
RUN apt-get --force-yes install -y nano
RUN apt-get --force-yes install -y psmisc


