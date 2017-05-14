#!/usr/bin/env sh
# Start the apache2 web server


APACHE_PIDF=/run/apache2/httpd.pid

# delete PID file (if old one exists)
rm -f "${APACHE_PIDF}"

httpd "${@}"
