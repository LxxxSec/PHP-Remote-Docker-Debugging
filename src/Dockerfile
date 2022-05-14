FROM php:7.4-cli

ENV ROOT_PASSWORD password

WORKDIR /

COPY ./src /var/www/html/
COPY ./flag/f14g_15_h3r3 /f14g_15_h3r3
COPY ./sh/start.sh /start.sh

RUN sed -i "s@http://deb.debian.org@https://mirrors.ustc.edu.cn@g" /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y openssh-server
RUN apt-get install -y net-tools

RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh/

EXPOSE 22
EXPOSE 80

ENTRYPOINT ["/bin/bash", "/start.sh"]