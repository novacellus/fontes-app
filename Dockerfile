FROM ubuntu:latest

#Update installation
RUN apt-get update && apt-get upgrade -y

#Install NoSketchEngine dependencies
RUN apt-get install -y antlr3 libpcre3 libpcre++-dev python python-cheetah python-simplejson libltdl7

#Install nginx with deps
RUN apt-get install -y apache2

#Copy installation packages
COPY pkgs/ /tmp/pkgs

#Install NoSketchEngine pkgs
RUN cd /tmp/pkgs && dpkg -i *.deb


#Post-installation steps
COPY conf/bonito/run.cgi /etc/bonito/run.cgi

#Copy corpora
RUN mkdir /home/corpora
COPY data/corpora /home/corpora
RUN mkdir /home/registry
COPY data/registry /home/registry

#Encode corpora
RUN encodevert -vc /home/registry/test

#Running server
#RUN /etc/init.d/apache2 start

EXPOSE 80 443
