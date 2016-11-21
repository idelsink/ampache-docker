#!/usr/bin/env sh

# configure
mkdir -p ${APACHE_WEB_ROOT} && chown -R apache:www-data ${APACHE_WEB_ROOT}
mkdir -p /run/apache2       && chown -R apache:www-data /run/apache2
