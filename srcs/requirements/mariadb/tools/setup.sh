#!/bin/bash

cat <<EOF >/tmp/init.sql
CREATE DATABASE IF NOT EXISTS ${SQLDB};
CREATE USER IF NOT EXISTS '${SQLUSER}'@'%' IDENTIFIED BY '${SQLPASS}';
GRANT ALL PRIVILEGES ON ${SQLDB}.* TO '${SQLUSER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOTPASS}';
FLUSH PRIVILEGES;
EOF

exec mysqld --user=mysql --init-file=/tmp/init.sql