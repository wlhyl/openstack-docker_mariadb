# image name lzh/mariadb:kilo
FROM mariadb:10.0.20

MAINTAINER Zuhui Liu penguin_tux@live.com

ENV BASE_VERSION 2015-07-01
ENV OPENSTACK_VERSION kilo


ENV DEBIAN_FRONTEND noninteractive

RUN echo "Asia/Shanghai" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN echo "deb http://debian.ustc.edu.cn/debian/ wheezy main non-free contrib" > /etc/apt/sources.list
RUN echo "deb http://debian.ustc.edu.cn/debian-security/ wheezy/updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://debian.ustc.edu.cn/debian/ wheezy-updates main non-free" >> /etc/apt/sources.list
RUN echo "deb http://debian.ustc.edu.cn/debian/ wheezy-backports main non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get clean

RUN env --unset=DEBIAN_FRONTEND

ADD mysqld_openstack.cnf /etc/mysql/conf.d/mysqld_openstack.cnf