#!/usr/bin/env sh

# setup folder
mkdir -p ${AMPACHE_DIR}
echo "=> Unzip ampache archive"
unzip -q /ampache-${AMPACHE_VER}_all.zip -d ${AMPACHE_DIR} && chown -R apache:www-data ${AMPACHE_DIR}
mkdir -p /var/log/ampache/ && chown -R apache:www-data /var/log/ampache/

# convert line ending from dos2unix
# ignoring all binary files
echo "=> Convert line ending with dos2unix in ampache files"
find "${APACHE_WEB_ROOT}" -type f -exec sh -c "file -i {} | grep -v binary >/dev/null" \; -exec dos2unix {} \;

# set parameters
sed -i 's/#\(.*rewrite_module.*\)/\1/g' /etc/apache2/httpd.conf
echo "PidFile /var/run/apache2.pid" >> /etc/apache2/httpd.conf

# cron update
echo "0 3 * * * apache www-data ${AMPACHE_DIR}/bin/catalog_update.inc" >> /etc/crontab

sed -i 's/\(post_max_size\).*/\1 = 50M/g' /etc/php5/php.ini
sed -i 's/\(upload_max_filesize\).*/\1 = 30M/g' /etc/php5/php.ini

# ampache.cfg.php.dist configuration
# local_web_path
#   if not set, subsonic won't function from local ip
sed -i "s/;local_web_path/local_web_path/g" ${AMPACHE_DIR}/config/ampache.cfg.php.dist

# waveform
sed -i "s/;waveform = \"false\"/waveform = \"true\"/g" ${AMPACHE_DIR}/config/ampache.cfg.php.dist

# tmp_dir_path
sed -i "s/;tmp_dir_path = \"false\"/tmp_dir_path = \"\/tmp\/ampache\"/g" ${AMPACHE_DIR}/config/ampache.cfg.php.dist
