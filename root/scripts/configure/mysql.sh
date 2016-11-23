#!/usr/bin/env sh

# configure mysql if not configured
mkdir -p ${MYSQL_DATA_DIR}  && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_DATA_DIR}
mkdir -p ${MYSQL_SOCKET%/*} && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_SOCKET%/*}
mkdir -p ${MYSQL_PID%/*}    && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_PID%/*}

# set my.cnf variables
sed -i "s@\(datadir\).*@\1 = $MYSQL_DATA_DIR@g" /etc/mysql/my.cnf
sed -i "s@\(port\).*@\1 = $MYSQL_PORT@g" /etc/mysql/my.cnf
sed -i "s@\(socket\).*@\1 = $MYSQL_SOCKET@g" /etc/mysql/my.cnf

if [[ ! -d ${MYSQL_DATA_DIR}/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $MYSQL_DATA_DIR"
    echo "=> Installing MySQL ..."
    mysql_install_db --datadir=${MYSQL_DATA_DIR} --user=${MYSQL_USER} > /dev/null 2>&1
    echo "=> Done!"
else
    echo "=> Using an existing volume of MySQL"
fi
