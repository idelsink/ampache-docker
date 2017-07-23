#!/usr/bin/env sh

# Replace $1 with $2 in $3
replaceInFile() {
    sed -i "s@${1}@${2}@g" ${3}
}

# configure
mkdir -p ${APACHE_WEB_ROOT} && chown -R ${APACHE_USER}:${APACHE_GROUP} ${APACHE_WEB_ROOT}
mkdir -p /run/apache2       && chown -R ${APACHE_USER}:${APACHE_GROUP} /run/apache2 # PID file path

# Set IP address
IP_ADDR=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
replaceInFile "\@IP_ADDRESS\@" "${IP_ADDR}:80" /etc/apache2/httpd.conf

# set apache user
replaceInFile "\@APACHE_USER\@" "${APACHE_USER}" /etc/apache2/httpd.conf
replaceInFile "\@APACHE_GROUP\@" "${APACHE_GROUP}" /etc/apache2/httpd.conf
