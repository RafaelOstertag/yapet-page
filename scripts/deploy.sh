#!/bin/sh
#
# Deploy built page to eventhorizon.dmz.kruemel using sftp.

set -e
set -u

REMOTE_USER=yapet-deploy
REMOTE_HOST=eventhorizon.dmz.kruemel.home
REMOTE_BASE=/var/www/jails/yapet/usr/local/www/apache24/data

cd public_html
sftp ${REMOTE_USER}@${REMOTE_HOST} <<EOF
cd ${REMOTE_BASE}
put -r .
bye
EOF
