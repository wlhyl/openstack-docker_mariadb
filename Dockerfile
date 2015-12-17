# image name lzh/mariadb:5.5.46
FROM mariadb:5.5.46

MAINTAINER Zuhui Liu penguin_tux@live.com

ENV BASE_VERSION 2015-07-01
ENV OPENSTACK_VERSION kilo


ENV DEBIAN_FRONTEND noninteractive

RUN echo "Asia/Shanghai" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN env --unset=DEBIAN_FRONTEND

RUN sed -i /log_warnings/s/2/1/g /etc/mysql/my.cnf
RUN sed -i /max_connections/s/100/500/g /etc/mysql/my.cnf

ADD mysqld_openstack.cnf /etc/mysql/conf.d/mysqld_openstack.cnf