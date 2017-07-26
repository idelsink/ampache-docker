#!/usr/bin/env sh
# Start the apache2 web server


# delete PID file (if old one exists)
rm -f "${APACHE_PID_FILE}"

# Set IP Address on startup
IP_ADDR=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
sed -i "s@\(^ServerName\).*@\ServerName ${IP_ADDR}@g" /etc/apache2/httpd.conf

httpd "${@}"
