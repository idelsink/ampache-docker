#!/usr/bin/env sh

# Configuring system if not yet configured
FIRST_TIME_SETUP_DONE=/var/ampache-docker/first-time-setup
if [ ! -f "${FIRST_TIME_SETUP_DONE}" ]; then
    /scripts/first-time-setup.sh && \
    mkdir -p "${FIRST_TIME_SETUP_DONE%/*}" && touch "${FIRST_TIME_SETUP_DONE}"
fi

# start supervisord
echo "~~ Starting the service manager supervisord ~~"
/usr/bin/supervisord -c /etc/supervisord.conf
