#!/usr/bin/env sh
# Start the apache2 web server


APACHE_PIDF=/run/apache2/httpd.pid
# delete PID file on exit
trap "{ rm -f ${APACHE_PIDF}; exit 255; }" EXIT

httpd "${@}"
