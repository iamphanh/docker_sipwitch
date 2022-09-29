FROM ubuntu:18.04


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

COPY install_pre /install_pre
RUN chmod 755 /install_pre
RUN /install_pre

COPY install_sipwitch /install_sipwitch
RUN chmod 755 /install_sipwitch
RUN /install_sipwitch

VOLUME /app

#WORKDIR /sipwitch_build/gnu_sipwitch/server 

COPY sipwitch.conf /etc/sipwitch.conf

ENTRYPOINT PLUGINS="auto" SECURITY="server" && sleep infinity

RUN /bin/bash -c "cd /usr/local/sbin" \ "sipw -f -vvv"