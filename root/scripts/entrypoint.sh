#!/usr/bin/env sh

echo "~~ Configuring system if not yet configured ~~"

/scripts/first-time-setup.sh

# start supervisord
echo "~~ Starting the service manager supervisord ~~"
/usr/bin/supervisord -c /etc/supervisord.conf
