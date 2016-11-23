#!/usr/bin/env sh
# start the mysql daemon in the background

# configure mysql
# start mysql
mysqld_safe \
--basedir=/usr \
--datadir=${MYSQL_DATA_DIR} \
--user=${MYSQL_USER} \
--pid-file=${MYSQL_PID} \
--skip-external-locking \
--port=${MYSQL_PORT} \
--socket=${MYSQL_SOCKET} \
${@} > /dev/null 2>&1
