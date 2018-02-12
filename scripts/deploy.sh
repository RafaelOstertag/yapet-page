#!/bin/sh
#
# Deploy built page to eventhorizon.dmz.kruemel using sftp.

REMOTE_BASE=/var/www/jails/yapet/usr/local/www/apache24/data

cd public_html
sftp yapet-deploy@eventhorizon.dmz.kruemel.home <<EOF
put -r .
bye
EOF
