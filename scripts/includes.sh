#!/bin/sh
#
# Include other html file
#
# The script assumes its current working directory is the repository
# root.
#
# The output goes to stdout.

set -e
set -u

if [ $# -ne 2 ]
then
    echo "`basename $0` <srcfile> <PAGETITLE>" >&2
    exit 1
fi

src_file=includes/`basename $1`
pagetitle=$2

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    ${pagetitle}
  </title>
  <content>
    <![CDATA[
    <main class="container">
        <section id="iframe-container" class="embed-responsive">
            <iframe id="include-iframe" class="embed-responsive-item" src="${src_file}"></iframe>
        </section>
    </main>]]>
  </content>
</fragment>
EOF
exit 0
