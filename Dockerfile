FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

COPY install_pre /install_pre
RUN chmod 755 /install_pre
RUN /install_pre

COPY install_sipwitch /install_sipwitch
RUN chmod 755 /install_sipwitch
RUN /install_sipwitch

VOLUME /app

COPY sipwitch.conf /etc/sipwitch.conf

ENTRYPOINT PLUGINS="auto" SECURITY="server" sipw -f -vvv
