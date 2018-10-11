#!/bin/sh
#
# Deploy built page using sftp. The script is expected to be called
# with the page root as the current working directory.

set -e
set -u

cd public_html
sftp ${REMOTE_USER}@${REMOTE_HOST} <<EOF
cd ${REMOTE_BASE}
put -r .
bye
EOF
