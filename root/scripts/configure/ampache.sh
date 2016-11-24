#!/usr/bin/env sh

# setup folder
mkdir -p ${AMPACHE_DIR}
unzip -q /ampache-${AMPACHE_VER}_all.zip -d ${AMPACHE_DIR} && chown -R apache:www-data ${AMPACHE_DIR}
mkdir -p /var/log/ampache/ && chown -R apache:www-data /var/log/ampache/

# set parameters
sed -i 's/#\(.*rewrite_module.*\)/\1/g' /etc/apache2/httpd.conf
echo "PidFile /var/run/apache2.pid" >> /etc/apache2/httpd.conf

# cron update
echo "0 3 * * * apache www-data ${AMPACHE_DIR}/bin/catalog_update.inc" >> /etc/crontab

sed -i 's/\(post_max_size\).*/\1 = 50M/g' /etc/php5/php.ini
sed -i 's/\(upload_max_filesize\).*/\1 = 30M/g' /etc/php5/php.ini
