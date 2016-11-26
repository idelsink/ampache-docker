#!/usr/bin/env sh

CONFIGURED_SUPERVISORD=/var/ampache-docker/configured/supervisord
CONFIGURED_APACHE=/var/ampache-docker/configured/apache
CONFIGURED_MYSQL=/var/ampache-docker/configured/mysql
CONFIGURED_AMPACHE=/var/ampache-docker/configured/ampache

echo "~~ Configuring system if not yet configured ~~"
# supervisord
if [ ! -f "${CONFIGURED_SUPERVISORD}" ]; then
    echo "~~ Configuring supervisord ~~"
    /scripts/configure/supervisord.sh && \
    mkdir -p ${CONFIGURED_SUPERVISORD%/*} && touch "${CONFIGURED_SUPERVISORD}"
fi
# apache
if [ ! -f "${CONFIGURED_APACHE}" ]; then
    echo "~~ Configuring apache ~~"
    /scripts/configure/apache.sh && \
    mkdir -p ${CONFIGURED_APACHE%/*} && touch "${CONFIGURED_APACHE}"
fi

# mysql
if [ ! -f "${CONFIGURED_MYSQL}" ]; then
    echo "~~ Configuring mysql ~~"
    /scripts/configure/mysql.sh && \
    mkdir -p ${CONFIGURED_MYSQL%/*} && touch "${CONFIGURED_MYSQL}"
fi

# ampache
if [ ! -f "${CONFIGURED_AMPACHE}" ]; then
    echo "~~ Configuring ampache ~~"
    /scripts/configure/ampache.sh && \
    mkdir -p ${CONFIGURED_AMPACHE%/*} && touch "${CONFIGURED_AMPACHE}"
fi


# start supervisord
echo "~~ Starting the service manager supervisord ~~"
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
