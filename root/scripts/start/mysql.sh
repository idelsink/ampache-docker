#!/usr/bin/env sh
# start the mysql daemon in the background

# configure mysql
# start mysql daemon in background
# mysqld_safe \
# --basedir=/usr \
# --datadir=/var/lib/mysql \
# --user=mysql \
# --pid-file=/var/run/mysqld/mysqld.pid \
# --skip-external-locking \
# --port=3306 \
# --socket=/var/run/mysqld/mysqld.sock ${@} > /dev/null 2>&1

mysqld_safe \
--basedir=/usr \
--datadir=${MYSQL_DATA_DIR} \
--user=${MYSQL_USER} \
--pid-file=${MYSQL_PID} \
--skip-external-locking \
--port=${MYSQL_PORT} \
--socket=${MYSQL_SOCKET} ${@} > /dev/null 2>&1
