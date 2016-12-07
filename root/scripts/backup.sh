#!/usr/bin/env sh
# backup Ampache
# - database
# - Ampache configuration

AMPACHE_CONF="${AMPACHE_DIR}/config/ampache.cfg.php"
AMPACHE_CONF_NAME="ampache.cfg.php"
DBNAME="MySQL.dump"

TYPE="${1:-""}"
DEST="${2:-"./"}"

case ${TYPE} in
    "b" )
        echo "~~ starting Ampache backup ~~"
        echo -n "Enter your MySQL root password and press [ENTER]: "
        read password
        echo "=> backing up database"
        mysqldump -uroot -p"${password}" --all-databases > "${DEST}/${DBNAME}"
        echo "=> backing up Ampache config"
        cp "${AMPACHE_CONF}" "${DEST}/${AMPACHE_CONF_NAME}"
        ;;
    "r" )
        echo "~~ starting Ampache restoration ~~"
        echo -n "Enter your current MySQL root password and press [ENTER]: "
        read password
        echo "=> restoring database"
        mysql -uroot -p"${password}" < "${DEST}/${DBNAME}"
        echo "=> restoring Ampache config"
        cp "${DEST}/${AMPACHE_CONF_NAME}" "${AMPACHE_CONF}"
        echo "=> restarting MySQL"
        supervisorctl stop mysql
        sleep 5
        supervisorctl start mysql
        echo "=> done restoring Ampache"
        ;;
    * )
        echo "missing"
        ;;
esac
