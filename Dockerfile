FROM ubuntu:14.04

MAINTAINER Dixon Martinez "https://github.com/dixon22ma"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget gzip tar
RUN apt-get clean

RUN mkdir /opt/Install/ \ && cd /opt/Install \ && mkdir /usr/local/jdk \ && mkdir /opt/Apps/ \ && chmod -R 0777 /opt/Apps
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar xvzf jdk-7u79-linux-x64.tar.gz -C /usr/local/jdk

#RUN update-alternatives --install /usr/bin/java java /usr/local/jdk/bin/java 1067
#RUN update-alternatives --install /usr/bin/javac javac /usr/local/jdk/bin/javac 1067
#RUN update-alternatives --install /usr/bin/javaws javaws /usr/local/jdk/bin/javaws 1067

#RUN update-alternatives --auto java
#RUN update-alternatives --auto javac
#RUN update-alternatives --auto javaws

ADD /home/travis/build/erpcya/adempiere_370_Fork/adempiere/Adempiere /opt/Apps/
RUN echo "JAVA_HOME='/usr/local/jdk'" >> /etc/profile
RUN echo "PATH='$PATH:/usr/local/jdk/bin'" >> /etc/profile 
RUN echo "ADEMPIERE_HOME='/opt/Apps/Adempiere'" >> /etc/profile
RUN echo "export JAVA_HOME" >> /etc/profile
RUN echo "export PATH" >> /etc/profile         
RUN echo "export ADEMPIERE_HOME" >> /etc/profile

source /etc/profile

RUN cd $ADEMPIERE_HOME
RUN sed -i  "s/IP/$(hostname -i)/g" AdempiereEnv.properties
RUN sed -i  "s/HOST/$(hostname)/g" AdempiereEnv.properties

RUN mkdir /var/run/sshd
RUN echo 'root:adempiere' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#sed -r "s@172.17.0.2@$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)@" /opt/Apps/Adempiere/AdempiereEnv.properties

RUN sh RUN_silentsetup.sh
#tar xvzf jboss.tar.gz
RUN sh utils/RUN_Server2.sh &

EXPOSE 8080
