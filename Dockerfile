FROM alpine:3.4
MAINTAINER Ingmar Delsink https://github.com/idelsink
label version="1.0.0" \
      description="Ampache docker image with Linux Alpine"

ENV APACHE_WEB_ROOT=/var/www/localhost \
    APACHE_USER=apache \
    APACHE_GROUP=www-data

ENV AMPACHE_VER=3.8.3 \
    AMPACHE_WEB_DIR=${APACHE_WEB_ROOT}/ampache

ENV MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_SOCKET=/var/run/mysqld/mysqld.sock \
    MYSQL_PID=/var/run/mysqld/mysqld.pid \
    MYSQL_PORT=3306 \
    MYSQL_USER=mysql

# update, upgrade and install:
# supervisor, apache2, mysql, pwgen, php, ffmpeg
RUN apk --no-cache update && \
    apk add --no-cache \
        apache2 \
        apache2-utils \
        apache2-webdav \
        ffmpeg \
        file \
        mysql \
        mysql-client \
        php5 \
        php5-apache2 \
        php5-curl \
        php5-dom \
        php5-gd \
        php5-gettext \
        php5-iconv \
        php5-json \
        php5-openssl \
        php5-pdo \
        php5-pdo_mysql \
        php5-sockets \
        php5-xml \
        php5-xmlreader \
        php5-zlib \
        pwgen \
        supervisor

WORKDIR /

ADD root \
    # https://github.com/ampache/ampache/releases/download/${AMPACHE_VER}/ampache-${AMPACHE_VER}_all.zip \
    ampache-${AMPACHE_VER}_all.zip \
    /

#    80: http
#   443: https (for future setup)
#  9001: supervisord web
# 32400: plex
EXPOSE 80 443 9001 32400

ENTRYPOINT [ "/scripts/entrypoint.sh" ]
