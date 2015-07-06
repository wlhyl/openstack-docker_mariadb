#!/bin/bash
export MYSQL_ROOT_PASSWORD=123456
export MYSQL_HOST=127.0.0.1
export KEYSTONE_DBPASS=123456
export GLANCE_DBPASS=123456

docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
    -v /opt/openstack/mysql/:/var/lib/mysql/ lzh/mariadb:kilo

mysql -h$MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD -N <<EOF

CREATE DATABASE IF NOT EXISTS keystone;

GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
  IDENTIFIED BY "$KEYSTONE_DBPASS";
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
  IDENTIFIED BY "$KEYSTONE_DBPASS";

CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
  IDENTIFIED BY "$GLANCE_DBPASS";
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
  IDENTIFIED BY "$GLANCE_DBPASS";

exit

EOF