#!/usr/bin/env sh
# update the ampache catalog

LOCKDIR=/var/lock/ampache
mkdir -p "${LOCKDIR}"
LF="${LOCKDIR}/.$(basename $0).lock"

(
    # stop if lock exists
    flock -x -n 200 || exit 1
    echo "~~ updating catalog ~~"
    php ${AMPACHE_DIR}/bin/catalog_update.inc

) 200>$LF
