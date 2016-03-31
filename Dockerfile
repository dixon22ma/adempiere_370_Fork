# Creating Docker Image
FROM ubuntu
MAINTAINER Dixon Martinez <dmartinez@erpcya.com>

ENV ADEMPIERE_HOME = /opt/Apps/Adempiere

#Update Packages
RUN apt-get update
RUN apt-get --force-yes install -y wget
RUN apt-get --force-yes install -y openssh-server
RUN apt-get --force-yes install -y nano
RUN apt-get --force-yes install -y psmisc
RUN apt-get --force-yes install -y git
RUN apt-get --force-yes install -y ant

RUN mkdir ADEMPIERE_HOME

WORKDIR ADEMPIERE_HOME

RUN git clone https://github.com/erpcya/adempiere_370_Fork.git

RUN ant build.xml

RUN cp adempiere_370_Fork/adempiere/Adempiere $ADEMPIERE_HOME

