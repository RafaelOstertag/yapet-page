#!/bin/sh
#
# Create fragments from YAPET htmlized man pages using xsltproc.
#
# The script assumes its current working directory is the repository
# root.
#
# The output goes to stdout.

if [ $# -ne 2 ]
then
    echo "`basename $0` <MANPAGE> <PAGETITLE>" >&2
    exit 1
fi

htmlmanpage_file=$1
pagetitle=$2
content=`xsltproc xslt/manpage.xslt "${htmlmanpage_file}"`

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    ${pagetitle}
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
