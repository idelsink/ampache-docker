#!/usr/bin/env sh

# configure
mkdir -p ${APACHE_WEB_ROOT} && chown -R apache:www-data ${APACHE_WEB_ROOT}
mkdir -p /run/apache2       && chown -R apache:www-data /run/apache2

IP_ADDR=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
sed -i "s@\(#ServerName\).*@\ServerName ${IP_ADDR}:80@g" /etc/apache2/httpd.conf
