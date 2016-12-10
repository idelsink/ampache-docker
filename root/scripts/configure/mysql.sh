#!/usr/bin/env sh

# set mysql paths
mkdir -p ${MYSQL_DATA_DIR}  && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_DATA_DIR}
mkdir -p ${MYSQL_SOCKET%/*} && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_SOCKET%/*}
mkdir -p ${MYSQL_PID%/*}    && chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_PID%/*}

# set my.cnf variables
sed -i "s@\(datadir\).*@\1 = $MYSQL_DATA_DIR@g" /etc/mysql/my.cnf
sed -i "s@\(port\).*@\1 = $MYSQL_PORT@g" /etc/mysql/my.cnf
sed -i "s@\(socket\).*@\1 = $MYSQL_SOCKET@g" /etc/mysql/my.cnf

# create datebase
if [[ ! -d ${MYSQL_DATA_DIR}/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $MYSQL_DATA_DIR"
    echo "=> Installing MySQL ..."
    mysql_install_db --datadir=${MYSQL_DATA_DIR} --user=${MYSQL_USER} > /dev/null 2>&1
    echo "=> Done!"
else
    echo "=> Using an existing volume of MySQL"
fi

# securing database
echo "=> Trying to secure database"
echo "=> Starting MySQL service"
/scripts/start/mysql.sh &
RET=1
while [[ $RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 2
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

MYSQL_ROOT_PASS=${MYSQL_ROOT_PASS:-$(pwgen -s 100 1)}

# when you forgot the password, this is the place of the generated password.
echo "${MYSQL_ROOT_PASS}" > $HOME/MYSQL_ROOT_PASS_$(date '+%Y%m%d_%H%M%S')

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PASS}') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Disable remote root access
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

echo "=> Databse is less vulnerable now; Stopping MySQL service"
mysqladmin -uroot shutdown -p${MYSQL_ROOT_PASS}
echo ""
echo "========================================================================"
echo "Random generated password for root is: "
echo "'${MYSQL_ROOT_PASS}' "
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -uroot -p<password> -h<host> -P<port>"
echo ""
echo "Change the above password if deemed necessary."
echo "MySQL user 'root' only allows local connections."
echo "========================================================================"
echo ""
